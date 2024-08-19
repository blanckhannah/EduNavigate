package server.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import server.Daos.TeacherDao;
import server.Models.Student;
import server.Models.Teacher;

import java.util.List;

@RestController
@RequestMapping("/teachers")
@CrossOrigin
public class TeacherController {
    private TeacherDao teacherDao;

    public TeacherController(TeacherDao teacherDao) {
        this.teacherDao = teacherDao;
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public List<Teacher> getAllTeachers() {
        return teacherDao.getAllTeachers();
    }

    @GetMapping("/{id}")
    public Teacher getTeacherById(@PathVariable int id) {
        Teacher teacher = teacherDao.getTeacherById(id);
        if(teacher == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Teacher not found");
        } else {
            return teacher;
        }
    }
    @PreAuthorize("permitAll()")
    @GetMapping("/byLastName")
    public List<Teacher> getTeachersByLastName(@RequestParam(defaultValue = "") String lastName) {
        List<Teacher> teachers = teacherDao.getTeacherByLastName(lastName);
        if(teachers == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Teacher not found");
        } else {
            return teachers;
        }
    }

    @GetMapping("/byStudentId")
    public Teacher getTeachersByStudentId(@RequestParam int studentId) {
        Teacher teacher = teacherDao.getTeacherByStudentId(studentId);
        if (teacher == null ) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No teachers found for the given student ID");
        } else {
            return teacher;
        }
    }
    @GetMapping("/{id}/students")
    public List<Student> getStudentsByTeacherId(@PathVariable int id) {
        return teacherDao.getStudentsByTeacherId(id);
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public Teacher createTeacher(@RequestBody Teacher teacher) {
        return teacherDao.createTeacher(teacher);
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PutMapping("/{id}")
    public Teacher updateTeacher(@RequestBody Teacher teacher, @PathVariable int id) {
        teacher.setId(id);
        return teacherDao.updateTeacher(teacher);
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{id}")
    public void deleteTeacher(@PathVariable int id) {
        int rowsAffected = teacherDao.deleteTeacherById(id);
        if(rowsAffected == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Teacher not found", null);
        }
    }
}
