CREATE OR ALTER PROCEDURE [dbo].[UpdateAddressAndDiscountCodes]
    @AddressId INT,
    @CustomerId INT,
    @RecipientName NVARCHAR(100),
    @RecipientPhone NCHAR(15),
    @Street NVARCHAR(100),
    @ProvinceId INT,
    @DistrictId INT,
    @WardId INT,
    @Country NVARCHAR(50),
    @ProductVariantIds NVARCHAR(MAX) -- Comma-separated list of product_variant_ids
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables for error handling
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @Success BIT = 1;
    DECLARE @Message NVARCHAR(4000) = 'Address updated and discount codes processed successfully';
    
    -- Begin the transaction
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Update or insert address information with optimized MERGE operation
        -- Include the missing recipient_name and recipient_phone fields
        MERGE [dbo].[addressv2] WITH (HOLDLOCK) AS target
        USING (SELECT @AddressId AS address_id) AS source
        ON (target.address_id = source.address_id)
        WHEN MATCHED THEN
            UPDATE SET 
                customer_id = @CustomerId,
                street = @Street,
                ward_id = @WardId,
                district_id = @DistrictId,
                province_id = @ProvinceId,
                country = @Country,
                recipient_name = @RecipientName,
                recipient_phone = @RecipientPhone
        WHEN NOT MATCHED THEN
            INSERT (address_id, customer_id, street, ward_id, district_id, province_id, country, recipient_name, recipient_phone)
            VALUES (@AddressId, @CustomerId, @Street, @WardId, @DistrictId, @ProvinceId, @Country, @RecipientName, @RecipientPhone);
        
        -- Optimized handling of discount codes
        IF @ProductVariantIds IS NOT NULL AND LEN(@ProductVariantIds) > 0
        BEGIN
            -- Use a more efficient string splitting approach with STRING_SPLIT if SQL Server 2016+
            -- Or fallback to the XML approach for earlier versions
            
            -- Option 1: For SQL Server 2016+ (more efficient)
            IF OBJECT_ID('sys.string_split') IS NOT NULL
            BEGIN
                UPDATE adc
                SET status = 'used',
                    used_at = GETDATE()
                FROM [dbo].[Account_Discount_Codes] adc
                INNER JOIN STRING_SPLIT(@ProductVariantIds, ',') s 
                    ON adc.product_variant_id = TRY_CAST(LTRIM(RTRIM(s.value)) AS INT)
                WHERE adc.customer_id = @CustomerId
                AND adc.status = 'available'
                AND TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) IS NOT NULL;
            END
            ELSE -- Option 2: For SQL Server versions before 2016
            BEGIN
                -- Create a temporary table with clustered index for better performance
                CREATE TABLE #TempProductVariantIds 
                (
                    product_variant_id INT NOT NULL PRIMARY KEY CLUSTERED
                );
                
                -- Fast XML parsing method
                INSERT INTO #TempProductVariantIds (product_variant_id)
                SELECT CAST(LTRIM(RTRIM(x.value)) AS INT)
                FROM (
                    SELECT [value] = N.c.value('.[1]', 'nvarchar(50)')
                    FROM (SELECT CAST('<i>' + REPLACE(@ProductVariantIds, ',', '</i><i>') + '</i>' AS XML) AS X) AS T
                    CROSS APPLY X.nodes('/i') AS N(c)
                ) AS x
                WHERE ISNUMERIC(LTRIM(RTRIM(x.value))) = 1;
                
                -- Update with optimized join
                UPDATE adc
                SET status = 'used',
                    used_at = GETDATE()
                FROM [dbo].[Account_Discount_Codes] adc WITH (ROWLOCK)
                INNER JOIN #TempProductVariantIds t 
                    ON adc.product_variant_id = t.product_variant_id
                WHERE adc.customer_id = @CustomerId
                AND adc.status = 'available';
                
                -- Clean up
                DROP TABLE #TempProductVariantIds;
            END
        END
        
        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Simplified error handling
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @Success = 0;
        SET @Message = @ErrorMessage;
    END CATCH;
    
    -- Return result with minimal fields for efficiency
    SELECT @Success AS 'Success', @Message AS 'Message';
END; 