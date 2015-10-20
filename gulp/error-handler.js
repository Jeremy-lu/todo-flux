var notify = require('gulp-notify');

module.exports = function() {
  var args = Array.prototype.slice.call(arguments);

  notify.onError(function(e) {
    console.log(e);
  }).apply(this, args);

  notify.onError({
    title: "Compile error",
    message: "<%= error.message %>"
  }).apply(this, args);

  this.emit('end');
};
