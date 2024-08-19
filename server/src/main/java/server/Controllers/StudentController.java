package server.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import server.Daos.StudentDao;
import server.Models.Student;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/students")
@CrossOrigin
public class StudentController {
    private final StudentDao studentDao;
    public StudentController(StudentDao studentDao) {
        this.studentDao = studentDao;
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public List<Student> getAllStudents() {
        return studentDao.getAllStudents();
    }

//    @GetMapping
//    public List<Student> getAllStudents(Principal principal) {
//        String username = principal.getName();
//        return studentDao.getAllStudents(username);
//    }

    @GetMapping("/{id}")
    public Student getStudentById(@PathVariable int id) {
        Student student = studentDao.getStudentById(id);
        if(student == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found");
        } else {
            return student;
        }
    }
    @GetMapping("/byLastName")
    public List<Student> getStudentByLastName(@RequestParam(defaultValue = "") String lastName) {
//        public List<Student> getStudentByLastName(@PathVariable String lastName) {
        List<Student> students = studentDao.getStudentsByLastName(lastName);
        if (students == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found");
        } else {
            return students;
        }
    }

    @GetMapping("/myStudents")
    public List<Student> getMyStudents(Principal principal) {
        String username = principal.getName();
        List<Student> students = studentDao.getStudentsByUsername(username);
        if (students == null || students.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Students not found");
        } else {
            return students;
        }
    }

    @GetMapping("/byTeacher")
    public List<Student> getStudentsByTeacher(@RequestParam (defaultValue = "") int id) {
        List<Student> students = studentDao.getStudentsByTeacherId(id);
        if (students == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Students not found");
        } else {
            return students;
        }
    }

    @GetMapping("/{id}/image")
    public ResponseEntity<String> getStudentImagePath(@PathVariable int id) {
        String imagePath = studentDao.getImagePathById(id);
        if (imagePath == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(imagePath);
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public Student createStudent(@RequestBody Student student){
        return studentDao.createStudent(student);
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PutMapping("/{id}")
    public Student updateStudent(@RequestBody Student student, @PathVariable int id) {
        student.setId(id);
        return studentDao.updateStudent(student);
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @ResponseStatus (HttpStatus.NO_CONTENT)
    @DeleteMapping("/{id}")
    public void deleteStudent(@PathVariable int id) {
        int rowsAffected = studentDao.deleteStudentById(id);
        if (rowsAffected == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found", null);
        }
    }
}
