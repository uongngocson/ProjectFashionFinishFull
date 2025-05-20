package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Size;
import local.example.demo.repository.SizeRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SizeService {
    private final SizeRepository sizeRepository;

    public List<Size> getAllSizes() {
        return sizeRepository.findAll();
    }
}
