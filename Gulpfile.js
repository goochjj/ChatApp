var gulp = require('gulp'),
    livereload = require('gulp-livereload');
 
gulp.task('reload', function() {
  gulp.src("chat/*").pipe(livereload());
});

gulp.task('watch', function() {
  livereload.listen();
  gulp.watch('chat/*', ['reload']);
});

