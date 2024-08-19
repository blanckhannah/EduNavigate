import axios from "axios";
import {store} from '../main';

const http = axios.create({
    baseURL: "http://localhost:8080"
});

export default {
    getAllStudents() {
        return http.get('/students', { headers: {Authorization: `Bearer ${store.state.token}` } });
    },
    getStudentById(id) {
        return http.get(`/students/${id}`, { headers: {Authorization: `Bearer ${store.state.token}` } });
    },
    getStudentImagePath(id) {
        return http.get(`/students/${id}/image`, { headers: {Authorization: `Bearer ${store.state.token}` } });
    },
    getMyStudents() {
        return http.get('/students/myStudents', { headers: {Authorization: `Bearer ${store.state.token}` } }); 
    },
    createStudent(student) {
        return http.post('/students', student, { headers: { Authorization: `Bearer ${store.state.token}` } });
    },
    deleteStudent(id) {
        return http.delete(`/students/${id}`, { headers: {Authorization: `Bearer ${store.state.token}` } });
    }
};
