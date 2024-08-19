package server.Daos;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import server.Exceptions.DaoException;
import server.Models.Student;
import server.Models.Teacher;

import java.util.ArrayList;
import java.util.List;
@Component
public class JdbcTeacherDao implements TeacherDao {
    private JdbcTemplate jdbcTemplate;
    public JdbcTeacherDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    private Logger log = LoggerFactory.getLogger(getClass());
    @Override
    public List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();

        String sql = "SELECT * FROM teacher";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);

        while(results.next()) {
            Teacher teacher = mapRowToTeacher(results);
            teachers.add(teacher);
        }
        return teachers;
    }

    @Override
    public Teacher getTeacherById(int id) {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher WHERE teacher_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            if(results.next()) {
                teacher = mapRowToTeacher(results);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return teacher;
    }

    @Override
    public List<Teacher> getTeacherByLastName(String lastName) {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teacher WHERE last_name ILIKE ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, "%" + lastName + "%");
            while(results.next()) {
                Teacher teacherResult = mapRowToTeacher(results);
                teachers.add(teacherResult);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return teachers;    }

    @Override
    public Teacher getTeacherByStudentId(int studentId) {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher t " +
                "JOIN student_teacher st ON t.teacher_id = st.teacher_id " +
                "WHERE st.student_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, studentId);
            if (results.next()) {
                teacher = mapRowToTeacher(results);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        if (teacher == null) {
            throw new DaoException("No teacher found for the given student ID");
        }
        return teacher;
    }

    @Override
    public Teacher createTeacher(Teacher teacher) {
        Teacher newTeacher = null;

        String sql = "INSERT INTO teacher (first_name, last_name, email) " +
                "VALUES (?, ?, ?) RETURNING teacher_id;";
        try {
            int newTeacherId = jdbcTemplate.queryForObject(sql, int.class, teacher.getFirstName(),
                    teacher.getLastName(), teacher.getEmail());
            newTeacher = getTeacherById(newTeacherId);
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return newTeacher;
    }

    @Override
    public Teacher updateTeacher(Teacher teacher) {
        Teacher updatedTeacher = null;

        String sql = "UPDATE teacher SET first_name = ?, last_name = ?, email = ? " +
                "WHERE teacher_id = ?;";
        try {
            int numberOfRows = jdbcTemplate.update(sql, teacher.getFirstName(), teacher.getLastName(), teacher.getEmail(), teacher.getId());
            if (numberOfRows == 0) {
                throw new DaoException("Zero rows affected, expected at least one");
            } else {
                updatedTeacher = getTeacherById((teacher.getId()));
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return updatedTeacher;    }

    @Override
    public int deleteTeacherById(int id) {
        int numberOfRows = 0;
        String deleteStudentTeacherSql = "DELETE FROM student_teacher WHERE teacher_id = ?;";
        String deleteTeacherSql = "DELETE FROM teacher WHERE teacher_id = ?;";
        try {
            jdbcTemplate.update(deleteStudentTeacherSql, id);
            numberOfRows = jdbcTemplate.update(deleteTeacherSql, id);
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return numberOfRows;
    }

    @Override
    public List<Student> getStudentsByTeacherId(int id) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.* FROM student s " +
                "JOIN student_teacher st ON s.student_id = st.student_id " +
                "WHERE st.teacher_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            while (results.next()) {
                Student student = mapRowToStudent(results);
                students.add(student);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return students;
    }

    public Teacher mapRowToTeacher (SqlRowSet result) {
        Teacher teacher = new Teacher();
        teacher.setId(result.getInt("teacher_id"));
        teacher.setFirstName(result.getString("first_name"));
        teacher.setLastName(result.getString("last_name"));
        teacher.setEmail(result.getString("email"));
        return teacher;
    }

    private Student mapRowToStudent(SqlRowSet result) {
        Student student = new Student();
        student.setId(result.getInt("student_id"));
        student.setFirst_name(result.getString("first_name"));
        student.setLast_name(result.getString("last_name"));
        student.setAddress(result.getString("address"));
        student.setGrade(result.getInt("grade"));
        return student;
    }
}
