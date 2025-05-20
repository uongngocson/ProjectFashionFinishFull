package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.model.entity.Employee;

import local.example.demo.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
@Transactional
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    // get all employees
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    // get employee by id
    public Employee getEmployeeById(Integer id) {
        return employeeRepository.findById(id).orElse(null);
    }

    // save employee
    public Employee saveEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    // delete employee
    public void deleteEmployee(Integer id) {
        employeeRepository.deleteById(id);
    }
}
