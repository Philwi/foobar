<template lang="pug">
.container
  .contact-us
    form(@submit.prevent="submit")
      input(placeholder="City" type="text" required=true name='city' v-model='city')
      input(placeholder="Radius" type="number" required=true name="km_radius" min=1 max=800 v-model='km_radius')
      input(placeholder="Date" type="date" required=true name="date" v-model="date")
      select(placeholder="Experience Level" required=true name="level" v-model='level')
        option(value="" disabled=true) Choose your experience level!
        option(value="kook") Kook
        option(value="intermediate") Intermediate
      template(v-if="loadingState")
        button(type="button" disabled=true) Loading...
      template(v-else)
        button(type="submit" @submit.prevent="submit") Search

  SpotCards
</template>

<script>
import { useSpotStore } from '@/stores/spots.store';
import { showToast } from '@/utils/showToast';
import SpotCards from '@/pages/website/SpotCards';

const spotStore = useSpotStore();

export default {
  components: { SpotCards },
  data() {
    return {
      date: new Date().toISOString().substr(0, 10),
      city: undefined,
      km_radius: 100,
      level: '',
    };
  },
  computed: {
    loadingState() {
      return spotStore.loadingState;
    },
    spots() {
      return spotStore.spots;
    },
    response() {
      return spotStore.response;
    },
  },
  watch: {
    response(newValue) {
      console.log(newValue);
      showToast(newValue.message, newValue.type);
    },
  },
  methods: {
    submit() {
      const spotQuery = {
        date: this.date,
        city: this.city,
        km_radius: this.km_radius,
        level: this.level,
      };

      spotStore.querySpots(spotQuery);
    },
  },
};
</script>

<style scoped="" lang="sass">
@import url('https://fonts.googleapis.com/css?family=Fjalla+One&display=swap')

$bg: "https://s3-us-west-2.amazonaws.com/s.cdpn.io/38816/image-from-rawpixel-id-2210775-jpeg.jpg"
$form-bg: #f8f4e5
$form-shadow: #ffa580
$form-primary-highlight: #95a4ff
$form-secondary-highlight: #ffc8ff
$font-size: 14pt
$font-face: 'Fjalla One'
$font-color: #2A293E

*
  margin: 0
  padding: 0

.container
  background: url($bg) center center no-repeat
  background-size: cover
  width: 100vw
  height: auto
  min-height: 100vh
  display: grid
  align-items: center
  justify-items: center

.contact-us
  background: $form-bg
  padding: 50px 100px
  margin-top:  3rem
  border: 2px solid rgba(0,0,0,1)
  box-shadow: 15px 15px 1px $form-shadow, 15px 15px 1px 2px rgba(0,0,0,1)

input
  display: block
  width: 100%
  font-size: $font-size
  line-height: $font-size * 2
  font-family: $font-face
  margin-bottom: $font-size * 2
  border: none
  border-bottom: 5px solid rgba(0,0,0,1)
  background: $form-bg
  min-width: 250px
  padding-left: 5px
  outline: none
  color: rgba(0,0,0,1)

input:focus
  border-bottom: 5px solid $form-shadow

select
  display: block
  width: 100%
  font-size: $font-size
  line-height: $font-size * 2
  font-family: $font-face
  margin-bottom: $font-size * 2
  border: none
  border-bottom: 5px solid rgba(0,0,0,1)
  background: $form-bg
  min-width: 250px
  padding-left: 5px
  outline: none
  color: rgba(0,0,0,1)

button
  display: block
  margin: 0 auto
  line-height: $font-size * 2
  padding: 0 20px
  background: $form-shadow
  letter-spacing: 2px
  transition: .2s all ease-in-out
  outline: none
  border: 1px solid rgba(0,0,0,1)
  box-shadow: 3px 3px 1px 1px $form-primary-highlight, 3px 3px 1px 2px rgba(0,0,0,1)

  &:hover
    background: rgba(0,0,0,1)
    color: white
    border: 1px solid rgba(0,0,0,1)

::selection
  background: $form-secondary-highlight

input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus
  border-bottom: 5px solid $form-primary-highlight
  -webkit-text-fill-color: $font-color
  -webkit-box-shadow: 0 0 0px 1000px $form-bg inset
  transition: background-color 5000s ease-in-out 0s

</style>
