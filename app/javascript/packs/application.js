// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import '../src/application.scss'

require('jquery');
require('data-confirm-modal');
// require("chartkick/chart.js")
require("chartkick").use(require("highcharts"))

const images = require.context("../images", true);
const imagePath = name => images(name, true);

Rails.start()
ActiveStorage.start()
