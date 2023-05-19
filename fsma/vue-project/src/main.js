//Fichero donde se inializa los paquetes que se van utilizar y la aplicacion
import { createApp, ref } from 'vue'
//Para los idiomas
import i18n from './components/i18n'
//La aplicación
import App from './App.vue'
//Para los estilos de la página 
import "bootstrap/scss/bootstrap.scss"
import * as bootstrap from 'bootstrap'
//Para el enrutado de las páginas
import router from "./router";
//Crea la aplicación
const app = createApp(App)
//Los paquetes que utilizan
app.use(router)
app.use(i18n)
//Variables globales
app.provide('SearchVisible',true)
app.config.globalProperties.$SearchVisible = ref(false)
app.config.globalProperties.$SearchBarVisible = ref(false)
app.config.globalProperties.$user = ref(null)
app.config.globalProperties.$region = ref(null)
//Montar la aplicación
app.mount('#app')

router.beforeEach((to, from, next)=>{
    //Válida que si está iniciado sesión el usuario no pueda acceder a register o login
        if((to.path=="/login" || to.path=="/register") && app.config.globalProperties.$user.value !== null){
        next({
            name:"Home",
        });
        return;
    }
    //Válida si al entrar en una ruta de serie o película contiene más que números
    if((to.name =='Serie' ||to.name == 'Movie') && !/^\d+$/.test(to.params.id)){
        next({
            name:"Home",
        });
        return;
    }
    next();
})