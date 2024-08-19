<script>
import StudentHome from '../components/StudentHome.vue';
import TeacherHome from '../components/TeacherHome.vue';

  export default {
    components: {
      StudentHome,
      TeacherHome
    },
    computed: {
      isAdmin() {
        return this.$store.state.userRoles.includes('ADMIN');
      }
    }
  }
</script>

<template>
  <div id="main-grid">
    <StudentHome/>
    <TeacherHome v-if="isAdmin"/>
  </div>
</template>

<style scoped>
#main-grid {
  display: flex;
  gap: 20px;
  margin: 20px;
}

#main-grid > * {
  border: 3px solid rgb(85, 99, 89);
  border-radius: 10px;
  background-color: rgb(227, 233, 238);
  box-shadow: 0px 5px 6px rgb(65, 67, 70);
}

#main-grid > *:first-child {
  flex-grow: 2;
}

#main-grid > *:last-child {
  flex-grow: 1;
}

@media (max-width: 768px) {
  header {
    font-size: 1rem;
  }

  #main-grid {
    flex-direction: column;
    gap: 0px;
    padding: 0px;
    justify-content: center;
    align-items: center;
  }

  #main-grid > * {
    width: 100%;
    border: 3px solid rgb(85, 99, 89);
    border-radius: 10px;
    background-color: rgb(227, 233, 238);
    box-shadow: 0px 5px 6px rgb(65, 67, 70);
    font-size: 0.9rem;
  }

  #main-grid > *:first-child {
    margin-bottom: 20px;
  }
}

</style>