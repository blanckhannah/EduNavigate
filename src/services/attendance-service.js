import axios from 'axios';
import {store} from '../main';

const http = axios.create({
    baseURL: "http://localhost:8080/attendance"
});

export default {
    getAttendanceByStudentId(id) {
        return http.get('/byStudentId', { params: { id } });
    }
};