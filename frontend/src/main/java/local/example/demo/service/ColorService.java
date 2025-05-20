package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Color;
import local.example.demo.repository.ColorRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ColorService {
    private final ColorRepository colorRepository;

    public List<Color> getAllColors() {
        return colorRepository.findAll();
    }

}
