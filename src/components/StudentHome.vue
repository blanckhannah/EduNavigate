<template>
  <div id="student-box">
    <h3>Students</h3>
    <button v-if="isAdmin" class="add-student-button" @click="goToAddStudentForm">+</button>
    <input type="text" v-model="searchQuery" placeholder="Search" @input="filterStudents" class="search-bar" />
    <div id="student-scroll">
      <ul v-if="filteredStudents.length">
        <li v-for="student in filteredStudents">
          <button @click="viewStudentDetails(student.id)">
            {{ student.first_name }} {{ student.last_name }}
            <span class="teacher-name">{{ teachers[student.id] || 'No Teacher' }}</span>
          </button>
        </li>
      </ul>
      <p v-else> No students available.</p>
    </div>
  </div>
</template>

<script>
import studentService from '@/services/student-service';
import teacherService from '@/services/teacher-service';

export default {
  name: 'StudentHome',
  data() {
    return {
      students: [],
      searchQuery: '',
      filteredStudents: [],
      teachers: {},
    };
  },
  computed: {
    isAdmin() {
      return this.$store.state.userRoles.includes('ADMIN');
    }
  },
  created() {
    this.getStudents();
    this.getMyStudents();
  },

  methods: {
    getStudents() {
      studentService.getAllStudents()
        .then(response => {
          console.log('Students Response:', response.data);
          this.students = response.data;
          this.getTeacherForStudents();
          this.filterStudents();
        }).catch(error => {
          console.error('Failed to get students', error);
        });
    },
    getMyStudents() {
      studentService.getMyStudents()
        .then(response => {
          this.students = response.data;
          this.getTeacherForStudents();
          this.filterStudents();
        }).catch(error => {
          console.error('Failed to get students', error);
        });
    },
    getTeacherForStudents() {
      this.students.forEach(student => {
        teacherService.getTeacherByStudentId(student.id).then(response => {
          this.teachers[student.id] = response.data.lastName || 'No Teacher';
        }).catch(error => {
          console.error(`Failed to get teacher for student ${student.id}`, error);
        });
      });
    },
    filterStudents() {
      const query = this.searchQuery.trim().toLowerCase();
      if (query) {
        this.filteredStudents = this.students.filter(student =>
          student.last_name.toLowerCase().includes(query)
        );
      } else {
        this.filteredStudents = this.students;
      }
    },
    viewStudentDetails(studentId) {
      this.$router.push(`/students/${studentId}`);
    },
    goToAddStudentForm() {
      this.$router.push('/students/add');
    }
  },
};

</script>

<style scoped>
#student-box {
  height: 90vh;
  border: 3px solid rgb(43, 71, 102);
  border-radius: 10px;
  margin: 20px;
  background-color: rgb(227, 233, 238);
  box-shadow: 0px 5px 6px rgb(43, 71, 102);
  position: relative;
}

#student-scroll {
  height: 80%;
  flex-grow: 1;
  overflow-y: auto;
}

#student-box h3 {
  text-align: center;
}

#student-box ul {
  padding: 10px;
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

#student-box li {
  list-style: none;
}

#student-box button:hover {
  background-color: rgb(139, 146, 148);
}

.search-bar {
  display: block;
  margin: 0 auto 20px auto;
  width: 85%;
  padding: 10px;
  font-size: 16px;
  border: 2px solid rgb(43, 71, 102);
  border-radius: 5px;
  box-shadow: 0px 1px 3px;
}

.add-student-button {
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

.add-student-button:hover {
  background-color: rgb(43, 71, 102);
}

@media (max-width: 768px) {
  #student-box {
    margin: 10px;
    padding: 10px;
  }

  #student-box h3 {
    font-size: 1.1rem; 
    margin: 8px;
  }

  .search-bar {
    font-size: 12px; 
    padding: 4px;
  }

  button {
    font-size: 14px; 
    padding: 4px;
  }

  .add-student-button {
    width: 25px; 
    height: 25px; 
    font-size: 20px;
  }
}
</style>