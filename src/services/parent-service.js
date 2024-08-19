import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080/parents"
});

export default {
    getParentByStudentId(studentId) {
        return http.get(`/byStudentId/${studentId}`, {headers: {Authorization: `Bearer ${store.state.login.token}`}});
    }
};