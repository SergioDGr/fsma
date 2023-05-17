//Donde se define el idioma
import { createI18n } from "vue-i18n";
import es from './languages/es.js'
import en from './languages/en.js'
//los mensajes que se mostraran dependiendo del idioma
const messages = {
    //En caso del idioma ingles
    en: en,
    //En caso del español
    es: es
}
//Se exporta el idioma
export default createI18n({
    locale: 'en',
    fallbackLocale: 'en',
    legacy: false,
    globalInjection: true,
    messages: messages
})