<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Login Now</div>
                    <div class="card-body">
                        <form @submit.prevent="login">
                            <div class="form-group row">
                                <label for="email" class="col-md-4 col-form-label text-md-right">E-Mail Address</label>

                                <div class="col-md-6">
                                    <input
                                        id="email"
                                        v-model="userForm.email"
                                        type="email"
                                        class="form-control"
                                        name="email"
                                        autocomplete="email"
                                        required
                                        autofocus
                                    />
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="password" class="col-md-4 col-form-label text-md-right">Password</label>

                                <div class="col-md-6">
                                    <input
                                        id="password"
                                        v-model="userForm.password"
                                        type="password"
                                        class="form-control"
                                        name="password"
                                        autocomplete="current-password"
                                        required
                                    />
                                </div>
                            </div>
                            <div class="form-group row mb-0">
                                <div class="col-md-6 offset-md-4">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            userForm: {
                email: '',
                password: '',
            },
        }
    },
    methods: {
        async login() {
            await this.$auth.login({
                data: this.userForm,
            })
            this.$router.push({
                path: '/',
            })
        },
    },
}
</script>
