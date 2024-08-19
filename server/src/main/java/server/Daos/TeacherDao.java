package server.Daos;

import server.Models.Student;
import server.Models.Teacher;

import java.util.List;

public interface TeacherDao {
    public List<Teacher> getAllTeachers();
    public Teacher getTeacherById(int id);
    public List<Teacher> getTeacherByLastName(String lastName);

    Teacher getTeacherByStudentId(int studentId);

    public Teacher createTeacher(Teacher teacher);
    public Teacher updateTeacher(Teacher teacher);
    public int deleteTeacherById(int id);

    List<Student> getStudentsByTeacherId(int id);
}
