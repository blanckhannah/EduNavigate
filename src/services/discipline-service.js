import axios from "axios";
import {store} from '../main';

const http = axios.create({
    baseURL: "http://localhost:8080/discipline"
});

export default {
    getDisciplinesByStudentId(id) {
        return http.get('/byStudentId', { params: { id } }
        // , {headers: {Authorization: `Bearer ${store.state.login.token}`}}
        );
    },
    createDiscipline(discipline) {
        return http.post('', discipline, { headers: { Authorization: `Bearer ${store.state.token}` } });
    },
    deleteDiscipline(disciplineId) {
        return http.delete(`/${disciplineId}`);
    }
};