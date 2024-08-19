import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import About from '../views/About.vue';
import Login from '../views/Login.vue';
import Register from '../views/Register.vue';
import Testing from '../views/Testing.vue';
import StudentDetails from '../views/StudentDetails.vue';
import TeacherDetails from '../views/TeacherDetails.vue';
import AddStudentForm from '../views/AddStudentForm.vue';
import AddTeacherForm from '../views/AddTeacherForm.vue';
import AddDisciplineForm from '../views/AddDisciplineForm.vue';
import { store } from '../main';

export function createAppRouter() {
    const router = createRouter({
        history: createWebHistory(),
        routes: [
            {
                path: '/',
                name: 'Home',
                component: Home,
                meta: {
                    requireAuth: true,
                }
            },
            {
                path: '/about',
                name: 'About',
                component: About,
                meta: {
                    requireAuth: true,
                }
            },
            {
                path: '/login',
                name: 'Login',
                component: Login,
                meta: {
                    requireAuth: false,
                }
            },
            {
                path: '/register',
                name: 'Register',
                component: Register,
                meta: {
                    requireAuth: false,
                }
            },
            {
                path: '/students/:id',
                name: 'StudentDetails',
                component: StudentDetails,
                meta: {
                    requireAuth: true
                }
            },
            {
                path: '/teacher/:id',
                name: 'TeacherDetails',
                component: TeacherDetails,
                meta: {
                    requireAuth: true
                }
            },
            {
                path: '/testing',
                name: 'Testing',
                component: Testing,
                meta: {
                    requireAuth: false,
                }
            },
            {
                path:'/students/add',
                name: 'AddStudent',
                component: AddStudentForm,
                meta: {
                    requireAuth: true,
                }
            },
            {
                path:'/teachers/add',
                name: 'AddTeacher',
                component: AddTeacherForm,
                meta: {
                    requireAuth: true
                }
            },
            {
                path: '/students/:id/createReferral',
                name: 'CreateReferral',
                component: AddDisciplineForm,
                meta: {
                    requireAuth: true
                }
            }
        ]
    });

    router.beforeEach((to, from, next) => {
        if (to.meta.requireAuth  && store.state.token === null) {
            next('/login');
        } else {
            next();
        }
    });
    
    return router;
}