<template>
    <div id="teacher-box">
      <h3>Teachers</h3>
      <button class="add-teacher-button" @click="goToAddTeacherForm">+</button>
      <ul v-if="teachers.length">
        <li v-for="teacher in teachers" :key="teacher.id">
          <button @click="viewTeacherDetails(teacher.id)">
            {{ teacher.firstName }} {{ teacher.lastName }}
          </button>
        </li>
      </ul>
      <p v-else>No teachers available.</p>
    </div>
  </template>
  
  <script>
  import teacherService from '@/services/teacher-service';
  
  export default {
    name: 'TeacherHome',
    data() {
      return {
        teachers: [],
      };
    },
    created() {
      this.getTeachers();
    },
    methods: {
      getTeachers() {
        teacherService.getTeachers('/teachers')
          .then(response => {
            this.teachers = response.data;
            console.log('Teachers:', this.teachers);
          })
          .catch(error => {
            console.error('Failed to get teachers', error);
          });
      },
      viewTeacherDetails(teacherId) {
        this.$router.push(`/teacher/${teacherId}`);
      },
      goToAddTeacherForm() {
        this.$router.push('/teachers/add');
      }
    },
  };
  </script>
  
<style scoped>
#teacher-box {
    height: 90vh;
    border: 3px solid rgb(85, 99, 89);
    border-radius: 10px;
    margin: 20px;
    background-color: rgb(227, 233, 238);
    box-shadow: 0px 5px 6px rgb(65, 67, 70);
    position: relative;
}

#teacher-box h3 {
    text-align: center;
}

ul {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0;
}

li {
  list-style-type: none;
  margin: 1%;
  border-radius: 3px;
  width: 90%;
}

button {
  border: 3px solid rgb(43, 71, 102);
  border-radius: 5px;
  background-color: rgb(68, 118, 153);
  padding: 6px;
  padding-left: 20px;
  margin: 1px;
  box-shadow: 0px 2px 3px;
  text-align: left;
  width: 100%;
  display: flex;
  justify-content: space-between;
}

#teacher-box button:hover {
  background-color: rgb(139, 146, 148);
}

.add-teacher-button {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: rgb(68, 118, 153);
  color: white;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  font-size: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  padding: 0;
}

.add-teacher-button:hover {
  background-color: rgb(43, 71, 102);
}

@media (max-width: 768px) {
  #teacher-box {
    margin: 10px;
    padding: 10px;
  }

  #teacher-box h3 {
    font-size: 1.1rem;
    margin: 8px;
  }

  ul {
    padding: 0;
  }

  li {
    margin: 1% 0;
    width: 100%;
  }

  button {
    font-size: 14px; 
    padding: 4px;
  }

  .add-teacher-button {
    width: 25px; 
    height: 25px; 
    font-size: 18px; 
  }
}

</style>