package server.Daos;

import server.Models.Parent;

import java.util.List;

public interface ParentDao {
    List<Parent> getAllParents();
    Parent getParentById(int id);
    List<Parent> getParentsByLastName(String lastName);
    List<Parent> getParentsByStudentId(int studentId);
    Parent createParent(Parent parent);
    Parent updateParent(Parent parent);
    int deleteParentById(int id);
}
