package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.entity.Supplier;
import local.example.demo.repository.SupplierRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SupplierService {
    private final SupplierRepository supplierRepository;

    // find by all supplier
    @Transactional(readOnly = true)
    public List<Supplier> findAllSuppliers() {
        return supplierRepository.findAll();
    }

    // find supplier by id
    @Transactional(readOnly = true)
    public Supplier findSupplierById(Integer supplierId) {
        return supplierRepository.findById(supplierId).orElse(null);
    }

    // save supplier
    @Transactional
    public void saveSupplier(Supplier supplier) {
        supplierRepository.save(supplier);
    }

    // delete supplier by id
    @Transactional
    public void deleteSupplierById(Integer supplierId) {
        supplierRepository.deleteById(supplierId);
    }
}
