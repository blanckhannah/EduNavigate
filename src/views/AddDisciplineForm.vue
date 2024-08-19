<template>
    <div id="create-discipline-form">
        <h3>Create New Discipline Record</h3>
        <form @submit.prevent="submitForm">
            <label>
                Referral Date:
                <input v-model="discipline.referralDate" type="date" required />
            </label>
            <label>
                Description:
                <textarea v-model="discipline.description" required></textarea>
            </label>
            <label>
                Action:
                <select v-model="discipline.disciplineAction" type="text" required>
                    <option value="" disabled>Select an action</option>
                    <option value="Warning">Warning</option>
                    <option value="PhoneCall">Phone Call Home</option>
                    <option value="Office">Office Visit</option>
                    <option value="Detention">Detention</option>
                    <option value="Suspension">Suspension</option>
                    <option value="Expulsion">Expulsion</option>
                </select>
            </label>
            <label>
                Parent Contacted:
                <input v-model="discipline.parentContacted" type="checkbox" />
            </label>
            <input v-model="discipline.studentId" type="hidden" />
            <button type="submit">Submit</button>
        </form>
    </div>
</template>

<script>
import disciplineService from '@/services/discipline-service';

export default {
    name: 'AddDisciplineForm',
    props: {
        studentId: {
            type: Number,
            required: true
        }
    },
    data() {
        return {
            discipline: {
                studentId: this.studentId,
                referralDate: '',
                description: '',
                disciplineAction: '',
                parentContacted: ''
            }
        };
    },
    methods: {
        submitForm() {
            disciplineService.createDiscipline(this.discipline)
                .then(() => {
                    this.$router.push('/students');
                })
                .catch(error => {
                    console.error('Failed to create referral', error);
                });
        }
    }
};
</script>

<style scoped>
#create-discipline-form {
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

input[type="date"],
input[type="text"],
input[type="number"],
textarea,
select {
    margin-bottom: 10px;
    padding: 8px;
    border: 1px solid rgb(43, 71, 102);
    border-radius: 5px;
}

textarea {
    resize: vertical;
    width: 100%;
}

button {
    margin-top: 20px;
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