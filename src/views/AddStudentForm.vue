<template>
    <div id="add-student-form">
      <h3>Add New Student</h3>
      <form @submit.prevent="submitForm">
        <label>
          First Name:
          <input v-model="student.first_name" type="text" required />
        </label>
        <label>
          Last Name:
          <input v-model="student.last_name" type="text" required />
        </label>
        <label>
          Address:
          <input v-model="student.address" type="text" required />
        </label>
        <label>
          Grade:
          <input v-model="student.grade" type="number" required />
        </label>
        <button type="submit">Submit</button>
      </form>
    </div>
  </template>

<script>
import studentService from '@/services/student-service';

export default {
  name: 'AddStudentForm',
  data() {
    return {
      student: {
        firstName: '',
        lastName: '',
        address: '',
        grade: ''
      }
    };
  },
  methods: {
    submitForm() {
      studentService.createStudent(this.student)
        .then(() => {
          this.$router.push('/');
        })
        .catch(error => {
          console.error('Failed to add student', error);
        });
    }
  }
};
</script>

<style scoped>
#add-student-form {
  margin: 20px;
  padding: 20px;
  border: 3px solid rgb(85, 99, 89);
  border-radius: 10px;
  background-color: rgb(227, 233, 238);
  box-shadow: 0px 5px 6px rgb(65, 67, 70);
}

h3 {
  text-align: center;
  margin-bottom: 20px;
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
  border: 1px solid rgb(43, 71, 102);
  border-radius: 5px;
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