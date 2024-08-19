<script>
import loginService from '../services/login-service';
export default {
    data() {
        return {
            username: '',
            password: '',
            rememberMe: false,
            errorMessage: null
        }
    },
    methods: {
        login() {
            loginService.login(this.username, this.password, this.rememberMe).then(loginResult => {
                if (!loginResult) {
                    this.errorMessage = 'Invalid username or password';
                } else {
                    this.$router.push('/');
                }
            });
        }
    }
}
</script>

<template>
    <form @submit.prevent="login">
        <h1>Login</h1>
        <p class="error" v-if="errorMessage">{{ errorMessage }}</p>

        <fieldset>
            <label>
                <span>Username </span>
                <input type="text" v-model="username" required>
            </label>
            <label>
                <span>Password </span>
                <input type="password" v-model="password" required>
            </label>
            <label>
                <input type="checkbox" v-model="rememberMe">
                <span>Remember me</span>
            </label>
            <button type="submit">Login</button>
        </fieldset>
        <RouterLink to="/register">Register a new account</RouterLink>
    </form>
</template>

<style scoped>
    form {
        width: 500px;
        margin: 50px auto 0 auto;
        padding: 50px;
        border: 1px solid #777;
        border-radius: 10px;
        gap: 1rem;
        box-shadow: var(--shadow-3);

        display: flex;
        flex-direction: column;
        align-items: center;
    }

    fieldset {
        border: none;
        display: grid;
        gap: 0.5rem;
        grid-template-columns: auto auto;
    }

    label {
        width: 80%;
        grid-column: span 2;
        display: grid;
        grid-template-columns: subgrid;
        gap: 1rem;
    }

    label:has(input[type="checkbox"]) {
        display: flex;
        width: 100%;
        justify-content: center;
    }

    button {
        grid-column: 2;
        width: 100%;
    }

    @media (max-width: 768px) {
  form {
    width: 90%;
    max-width: 400px;
    padding: 2px;
    margin: 0px auto;
    border: 1px solid #777;
    border-radius: 10px;
    box-shadow: var(--shadow-3);
  }

  label {
    display: flex;
    flex-direction: column;
  }

  input[type="text"],
  input[type="password"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  fieldset {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  button {
    width: 100%;
    padding: 10px;
    background-color: rgb(68, 118, 153);
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  button:hover {
    background-color: rgb(43, 71, 102);
  }

}
</style>