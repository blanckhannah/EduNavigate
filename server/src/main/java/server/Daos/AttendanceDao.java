package server.Daos;

import server.Models.Attendance;

import java.util.List;

public interface AttendanceDao {
    public List<Attendance> getAllAttendances();
    public Attendance getAttendanceById(int id);
    public List<Attendance> getAttendanceByStudentId(int id);
    public List<Attendance> getAttendanceByStudentName(String lastName, String firstName);
    public Attendance createAttendance(Attendance attendance);
    public Attendance updateAttendance(Attendance attendance);
    public int deleteAttendanceById(int id);
}
