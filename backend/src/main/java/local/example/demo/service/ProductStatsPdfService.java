package local.example.demo.service;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.events.Event;
import com.itextpdf.kernel.events.IEventHandler;
import com.itextpdf.kernel.events.PdfDocumentEvent;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class ProductStatsPdfService {

    public byte[] generateProductStatsReport(List<Object[]> productStats, int year, int month) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try (PdfWriter writer = new PdfWriter(baos);
                PdfDocument pdfDoc = new PdfDocument(writer);
                Document document = new Document(pdfDoc)) {

            // Set document margins
            document.setMargins(40, 40, 40, 40);

            // Add header (company logo or name)
            Paragraph header = new Paragraph()
                    .add(new Text("AlphaMart\n").setFontSize(20).setBold().setFontColor(ColorConstants.BLUE))
                    .add(new Text("Product Revenue Report").setFontSize(16).setBold())
                    .setTextAlignment(TextAlignment.CENTER);
            document.add(header);

            // Add report generation date
            String reportDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
            Paragraph date = new Paragraph("Generated on: " + reportDate)
                    .setFontSize(10)
                    .setTextAlignment(TextAlignment.RIGHT)
                    .setMarginBottom(10);
            document.add(date);

            // Add subtitle: Period
            Paragraph period = new Paragraph("Month: " + month + "/" + year)
                    .setFontSize(12)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(period);

            // Table for product statistics
            float[] columnWidths = { 1, 3, 2, 2 };
            Table table = new Table(UnitValue.createPercentArray(columnWidths));
            table.setWidth(UnitValue.createPercentValue(100));

            // Table headers with styling
            table.addHeaderCell(new Cell().add(new Paragraph("Product ID").setBold())
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY));
            table.addHeaderCell(new Cell().add(new Paragraph("Product Name").setBold())
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY));
            table.addHeaderCell(new Cell().add(new Paragraph("Total Revenue").setBold())
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY));
            table.addHeaderCell(new Cell().add(new Paragraph("Total Quantity").setBold())
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY));

            // Table data
            for (Object[] row : productStats) {
                Integer productId = (Integer) row[0];
                String productName = (String) row[1];
                BigDecimal totalRevenue = (BigDecimal) row[2];
                Integer totalQuantity = (Integer) row[3];

                table.addCell(new Paragraph(productId != null ? String.valueOf(productId) : "Unknown"));
                table.addCell(new Paragraph(productName != null ? productName : "Unknown"));
                table.addCell(new Paragraph(totalRevenue != null ? "$" + totalRevenue.toString() : "Unknown")
                        .setFontColor(ColorConstants.GREEN));
                table.addCell(new Paragraph(totalQuantity != null ? String.valueOf(totalQuantity) : "Unknown"));
            }

            document.add(table);

            // Add footer (page number)
            pdfDoc.addEventHandler(PdfDocumentEvent.END_PAGE, new PageNumberEventHandler());

        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF report: " + e.getMessage(), e);
        }

        return baos.toByteArray();
    }

    // Custom event handler for page numbers
    private static class PageNumberEventHandler implements IEventHandler {
        @Override
        public void handleEvent(Event event) {
            PdfDocumentEvent docEvent = (PdfDocumentEvent) event;
            PdfDocument pdfDoc = docEvent.getDocument();
            PdfPage page = docEvent.getPage();
            PdfCanvas canvas = new PdfCanvas(page);
            try {
                canvas.beginText()
                        .setFontAndSize(PdfFontFactory.createFont(), 10)
                        .moveText(500, 20)
                        .showText("Page " + pdfDoc.getPageNumber(page))
                        .endText();
            } catch (Exception e) {
                throw new RuntimeException("Error adding page number: " + e.getMessage(), e);
            } finally {
                canvas.release();
            }
        }
    }
}