import axios from 'axios';
import {store} from '../main';

const http = axios.create({
    baseURL: "http://localhost:8080"
});

export default {
  getTeachers() {
    return http.get('/teachers', { headers: {Authorization: `Bearer ${store.state.token}` } });
  },
  getTeacherByStudentId(studentId) {
    return http.get(`/teachers/byStudentId`, {params: {studentId}}, { headers: {Authorization: `Bearer ${store.state.token}` } });
  },
  getTeacherById(id) {
    return http.get(`/teachers/${id}`, { headers: {Authorization: `Bearer ${store.state.token}` } });
  },
  getStudentsByTeacher(id) {
    return http.get('/students/byTeacher', { params: { id } }, { headers: {Authorization: `Bearer ${store.state.token}` } });
  },
  getTeacherByLastName(lastName) {
    return http.get('/teachers/byLastName', { params: { lastName } }, { headers: {Authorization: `Bearer ${store.state.token}` } });
  },
  createTeacher(teacher) {
    return http.post('/teachers', teacher, { headers: { Authorization: `Bearer ${store.state.token}` } });
  },
  deleteTeacher(id) {
    return http.delete(`/teachers/${id}`, { headers: { Authorization: `Bearer ${store.state.token}` } })
  }
};