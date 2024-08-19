<template>
    <div id="add-teacher-form">
      <h3>Add Teacher</h3>
      <form @submit.prevent="submitForm">
        <label>First Name:</label>
        <input type="text" v-model="teacher.firstName" id="firstName" required />
  
        <label for="lastName">Last Name:</label>
        <input type="text" v-model="teacher.lastName" id="lastName" required />
  
        <label for="address">Email:</label>
        <input type="text" v-model="teacher.email" id="email" required />
  
        <button type="submit">Add Teacher</button>
      </form>
    </div>
  </template>
  
  <script>
  import teacherService from '@/services/teacher-service';
  
  export default {
    name: 'AddTeacherForm',
    data() {
      return {
        teacher: {
            firstName: '',
            lastName: '',
            email: ''
        }
      };
    },
    methods: {
      submitForm() {
        teacherService.createTeacher(this.teacher)
          .then(() => {
            this.$router.push('/');
          })
          .catch(error => {
            console.error('Failed to add teacher', error);
          });
      }
    }
  };
  </script>
  
  <style scoped>
  #add-teacher-form {
    margin: 20px;
  }
  
  form {
    display: flex;
    flex-direction: column;
  }
  
  label {
    margin-top: 10px;
  }
  
  input {
    margin-bottom: 10px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  
  button {
    background-color: rgb(68, 118, 153);
    color: white;
    border: none;
    padding: 10px;
    border-radius: 5px;
    cursor: pointer;
  }
  
  button:hover {
    background-color: rgb(43, 71, 102);
  }
  </style>