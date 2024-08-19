package server.Daos;

import server.Models.Discipline;

import java.util.List;

public interface DisciplineDao {
    List<Discipline> getAllDisciplines();
    Discipline getDisciplineById(int id);
    List<Discipline> getDisciplineByStudentId(int id);
    List<Discipline> getDisciplineByStudentName(String lastName, String firstName);
    Discipline createDiscipline(Discipline discipline);
    Discipline updateDiscipline(Discipline discipline);
    int deleteDisciplineById(int id);
}
