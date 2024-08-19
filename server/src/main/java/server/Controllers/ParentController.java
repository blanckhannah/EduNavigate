package server.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import server.Daos.ParentDao;
import server.Models.Parent;

import java.util.List;

@RestController
@RequestMapping("/parents")
@CrossOrigin
public class ParentController {
    private final ParentDao parentDao;

    public ParentController(ParentDao parentDao) {
        this.parentDao = parentDao;
    }

    @GetMapping
    public List<Parent> getAllParents(){
        return parentDao.getAllParents();
    }

    @GetMapping("/{id}")
    public Parent getParentById(@PathVariable int id) {
        Parent parent = parentDao.getParentById(id);
        if(parent == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Parent not found");
        } else {
            return parent;
        }
    }

    @GetMapping("/byLastName")
    public List<Parent> getParentByLastName(@RequestParam(defaultValue = "") String lastName) {
        List<Parent> parents = parentDao.getParentsByLastName(lastName);
        if (parents == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Parent not found");
        } else {
            return parents;
        }
    }

    @GetMapping("/byStudentId")
    public List<Parent> getParentByStudentId(@RequestParam int studentId) {
        List<Parent> parents = parentDao.getParentsByStudentId(studentId);
        if (parents == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Parents not found for the given student ID");
        } else {
            return parents;
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public Parent createParent(@RequestBody Parent parent) {
        return parentDao.createParent(parent);
    }

}
