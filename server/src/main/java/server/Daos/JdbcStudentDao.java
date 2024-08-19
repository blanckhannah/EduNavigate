package server.Daos;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import server.Exceptions.DaoException;
import server.Models.Student;

import java.util.ArrayList;
import java.util.List;
@Component
public class JdbcStudentDao implements StudentDao {
    private JdbcTemplate jdbcTemplate;
    private JdbcUserDao jdbcUserDao;
    public JdbcStudentDao(JdbcTemplate jdbcTemplate, JdbcUserDao jdbcUserDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.jdbcUserDao = jdbcUserDao;
    }
    private Logger log = LoggerFactory.getLogger(getClass());
    @Override
    public Student getStudentById(int id) {
        Student student = null;
        String sql = "SELECT * FROM student WHERE student_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            if (results.next()) {
                student = mapRowToStudent(results);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return student;
    }

    @Override
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student ORDER BY last_name";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
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

//    @Override
//    public List<Student> getAllStudents(String username) {
//        List<String> roles = jdbcUserDao.getUserRoles(username);
//        log.info("Roles for user {}: {}", username, roles);
//
//        String sql;
//        if(roles.contains("ADMIN")) {
//            sql = ("SELECT * FROM student ORDER BY last_name");
//        } else {
//            sql = ("SELECT * FROM student " +
//                    "JOIN student_teacher ON student_teacher.student_id = student.student_id " +
//                    "JOIN teacher ON teacher.teacher_id = student_teacher.teacher_id " +
//                    "WHERE (teacher.username) = ? " +
//                    "ORDER BY student.last_name;");
//        }
//        SqlRowSet results;
//        try {
//            results = jdbcTemplate.queryForRowSet(sql, username);
//        } catch (Exception e) {
//            throw new DaoException("Error executing query", e);
//        }
//        List<Student> students = new ArrayList<>();
//        while (results.next()) {
//            Student student = mapRowToStudent(results);
//            students.add(student);
//        }
//        return students;
//    }

    @Override
    public List<Student> getStudentsByLastName(String lastName) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM Student WHERE last_name ILIKE ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, "%" + lastName + "%");
            while (results.next()) {
                Student studentResult = mapRowToStudent(results);
                students.add(studentResult);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return students;
    }

    @Override
    public List<Student> getStudentsByTeacherId(int id) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student JOIN student_teacher ON student_teacher.student_id = student.student_id " +
                "JOIN teacher ON teacher.teacher_id = student_teacher.teacher_id " +
                "WHERE teacher.teacher_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            while (results.next()) {
                Student studentResult = mapRowToStudent(results);
                students.add(studentResult);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return students;
    }
    @Override
    public List<Student> getStudentsByUsername(String username) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student JOIN student_teacher ON student_teacher.student_id = student.student_id " +
                "JOIN teacher ON teacher.teacher_id = student_teacher.teacher_id " +
                "WHERE teacher.username = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, username);
            while (results.next()) {
                Student studentResult = mapRowToStudent(results);
                students.add(studentResult);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return students;
    }

    @Override
    public List<Student> getStudentsByTeacherName(String lastName) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student JOIN student_teacher ON student_teacher.student_id = student.student_id " +
                "JOIN teacher ON teacher.teacher_id = student_teacher.teacher_id " +
                "WHERE teacher.lastName = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, "%" + lastName + "%");
            while (results.next()) {
                Student studentResult = mapRowToStudent(results);
                students.add(studentResult);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return students;
    }

    @Override
    public Student createStudent(Student student) {
        Student newStudent = null;

        String sql = "INSERT INTO student (first_name, last_name, address, grade) " +
                "VALUES (?, ?, ?, ?) RETURNING student_id;";
        try {
            int newStudentId = jdbcTemplate.queryForObject(sql, int.class, student.getFirst_name(), student.getLast_name(),
                    student.getAddress(), student.getGrade());
            newStudent = getStudentById(newStudentId);
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return newStudent;
    }

    @Override
    public Student updateStudent(Student student) {
        Student updatedStudent = null;

        String sql = "UPDATE student SET first_name = ?, last_name = ?, address = ?, grade = ? " +
                "WHERE student_id = ?;";
        try {
            int numberOfRows = jdbcTemplate.update(sql, student.getFirst_name(), student.getLast_name(), student.getAddress(), student.getGrade(), student.getId());
            if (numberOfRows == 0) {
                throw new DaoException("Zero rows affected, expected at least one.");
            } else {
                updatedStudent = getStudentById(student.getId());
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return updatedStudent;
    }

    @Override
    public int deleteStudentById(int id) {
        int numberOfRows = 0;
        String deleteAttendanceSql = "DELETE FROM attendance WHERE student_id = ?;";
        String deleteDisciplineSql = "DELETE FROM discipline WHERE student_id = ?;";
        String deleteStudentTeacherSql = "DELETE FROM student_teacher WHERE student_id = ?;";
        String deleteStudentParentSql = "DELETE FROM student_parent WHERE student_id = ?;";
        String deleteStudentSql = "DELETE FROM student WHERE student_id = ?;";

        try {
            jdbcTemplate.update(deleteAttendanceSql, id);
            jdbcTemplate.update(deleteDisciplineSql, id);
            jdbcTemplate.update(deleteStudentTeacherSql, id);
            jdbcTemplate.update(deleteStudentParentSql, id);
            numberOfRows = jdbcTemplate.update(deleteStudentSql, id);
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return numberOfRows;
    }

    @Override
    public String getImagePathById(int id) {
        String sql = "SELECT image_path FROM student WHERE student_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, String.class, id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Student mapRowToStudent (SqlRowSet result) {
        Student student = new Student();
        student.setId(result.getInt("student_id"));
        student.setFirst_name(result.getString("first_name"));
        student.setLast_name(result.getString("last_name"));
        student.setAddress(result.getString("address"));
        student.setGrade(result.getInt("grade"));
        return student;
    }
}
