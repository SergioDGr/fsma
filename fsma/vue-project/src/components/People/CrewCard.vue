<!--Componente que se añade a otros para la visualizacion de cada Staff-->
<template>
    <div class="card flex-row">
        <!--Perfil-->
        <div class="col-3 align-self-center">
            <img v-if="profile_path" class="rounded" :src="image" />
            <img v-else class="rounded " :src="image_default" />
        </div>
        <!--El trabajo que hace, de que se le conoce y su nombre-->
        <div class="card-body ">
            <div class="nombres">
                <p class="mb-1 text-start">
                    <strong>{{ job }}</strong> 
                    ({{ known_for_department }})
                </p>
                <hr>
                <p class="mb-1"><em>{{ name }}</em></p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    //Parametros que se pasan
    props:{
        profile_path : String,
        known_for_department: String,
        image: String,
        name: String,
        job: String
    },
    data(){
        image_default: './images/default_image_actor.png'
    }
}
</script>