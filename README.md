# Sass Workshop - RailsConf 2018 

## What is Sass?

- **S**yntactically **A**wesome **S**tyle **S**heets 
- An extension of CSS - compiled to CSS.
- Coded in Ruby :boom:!! 
- All CSS is valid Sass but all Sass is not valid CSS.
- Supports other frameworks (i.e. Bootstrap, Materialize)
- Use file extension `.scss (Sassy CSS. more commonly used syntax)` or `.sass (older syntax)`.
- Provides variables, nesting, mixins, and selector inheritance.

## I am a backend developer, why should I care?

- Industry-wide = you will see it more often.
- Has a lot of features which help with ORGANIZATION!
- Allow for some principles of OOP. 
- "Cascading" is confusing!
- Mostly, so other developers don't look at your frontend code like: 

![What The...](https://media.giphy.com/media/9QeSVgwB6i5Ik/giphy.gif)

## Learning Goals

* Explain why SASS is a better option than raw CSS.
* Be able to set up SASS in a Rails project.
* Understand how to create variables in SASS.
* Understand how to nest elements in SASS.
* Understand how to nest properties in SASS.
* Break files up in a logical way.

## CSS Refresh

* To target an element in CSS such as a `<p>` tag: `p`
* To target a class in CSS: `.class`
* To target an id in CSS: `#id`
* End a CSS statement: `;`
* Cascading - What is it?

### Cascading 

A stylesheet looks from rule to rule and calculates specificity. `Specificity is basically a measure of how specific a selector is` (from the MDN docs).

## Workshop

### Setup 

- We are going to use [this](https://github.com/icorson3/sass_workshop) repository for this workshop. 
- Clone the repository.
- Change directories into `sass_workshop`.
- Bundle (to get all the gems!).
- Run `rake db:create db:migrate db:seed` from the terminal to setup the database with movies.
- Start up a rails server (`rails s`) from the terminal and navigate to [localhost:3000](http://localhost:3000/) to see the application. 
- We will use the root url for the workshop.

### Configuration 

- There are a few things that we must do in a rails application to make Sass work the way that we want:
  - Check in the `Gemfile` to see if `gem 'sass-rails'` is included. It is included in Rails versions > 3.1 but you may need to add it to earlier Rails versions. 
  - Rename `application.css` to `application.scss` because we will be writing Sass and we need to tell Rails that it should be compiled to CSS. We can also use `application.scss` to provide the same benefits.
  - Create a `base.scss` file under `assets/stylesheets`. This is where we will write our Sass code.

### Color Palette 

-  Here is the color palette that we will be using:

![color palette](https://user-images.githubusercontent.com/14942680/37047189-786710c4-2127-11e8-9394-bc4be403bfc8.png)

### Feature #1 - Variables

- Defining variables is fundamental to programming. One thing that was always frustrating about CSS, was the inability to reuse CSS code. NOT ANYMORE!
- To define a variable, we use a `$` to declare the variable and a `:` to assign it.
- Let's define a variable for the hex color #3D348B and define it for the font color of all `h1` elements and #E0E2DB as the background color. 

```scss 
// base.scss

$indigo-header: #3D348B;
$lighter-gray: #E0E2DB;

h1 {
  color: $indigo-header;
  background-color: $lighter-gray;
}
```

- Our app is pretty small right now so keeping track of colors is simple but imagine as our app grows and we have to continually look back for our hex codes. By creating variables, we can easily access these colors at any point. 
- On your own: 
  - Define the rest of the color palette with variables. 
  - Assign all `h2` elements to the variable you set the hex #191716
  - Create a variable called `custom-border` and assign border rules so that a 3 pixel dotted border in the color #E6AF2E around all `p` elements.
  
The results should be something like:
  
```scss 
// base.scss

$indigo-header: #3D348B;
$maroon: #800000;
$mustard: #E6AF2E;
$lighter-gray: #E0E2DB;
$darker-gray: #BEB7A4;

$custom-border: 3px dotted $mustard;

h1 {
  color: $indigo-header;
  background-color: $lighter-gray;
}

h2 {
  color: $maroon;
}

p {
  border: $custom-border;
}
```

What if we just want the `<h1>` on the `movies#index` to be `$darker-gray` but other `h1`'s to be `$indigo-header`?

## Feature #2 - Nesting 

### Elements

We can NEST our html elements in the same structure the our page has. This provides more readable code and an actual STRUCTURE for our CSS. FINALLY!!!

```scss
  h1 {
    color: $indigo-header;
    background-color: $lighter-gray;
  }
  
  h2 {
    color: $maroon;
  }

  p {
    border: $custom-border;
  }

  .movie-index {
    h1 {
      color: $darker-gray;
    }
  }
```

Run `rails s` and visit the route `http://localhost:3000` to see the CSS. Inspect the CSS and see that it compiles as we expect to see CSS code! COOL!

Benefits:

- Readibility 
- Maintainability
- Namespaces: Pretty and concise class names

*As a general rule: Do not nest more than 3 levels deep. Anything more affects the readability of the code*

### Properties

Another great benefit of sass is that we can nest our properties for further clarification and organization.

Let's give our `h2` a class selector and center our `second-header` in our `movie-index` and strikethrough the text.

```scss
  h1 {
    color: $indigo-header;
    background-color: $lighter-gray;
  }
  
  h2 {
    color: $maroon;
  }

  p {
    border: $custom-border;
  }
  
  .movie-index {
    h1 {
      color: $darker-gray;
    }
   
    .movie-show-link {
      text: {
        align: center;
        decoration: line-through;
      }
    }
  }
```

Let's navigate to our browser and inspect the `h2` element on our `movie-index`. When this sass code gets compiled, we see that it is automatically namespaced and if it is an actual property in CSS, it gets applied. It will try to compile, no matter what. For example, let's look at this in the browser: 

```scss 
 .movie-index {
    .movie-show-link {
      text: {
        align: center;
        decoration: line-through;
        cool: papyrus;
      }
    }
  }
```

On your own, add a font family of `papyrus` and a size of 30px to the `<p>` tag under `.movie-index`

## Key to success: Modularity

HTML and CSS deserve to be as DRY as your Ruby is. This is difficult to achieve in raw HTML and CSS. 

Splitting CSS files into smaller files also requires more HTTP requests. Sass provides a benefit by compiling all files into one by using import statements to bring files into one file. While this isn't necessarily a problem in Rails because of the asset pipeline, it can potentially slow down an application.

Right now, our `application.scss` file looks like this and is set up for Sprocket directives:

```scss 
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
```

With plain css files, the above lines that begin with `*=` require all stylesheets from the current directory. But with Sass, we do not want to utilize the Sprockets directives so need to modify our file. More from ["Rails Guides"](http://guides.rubyonrails.org/asset_pipeline.html):

```
If you want to use multiple Sass files, you should generally use the Sass @import rule instead of these Sprockets directives. When using Sprockets directives, Sass files exist within their own scope, making variables or mixins only available within the document they were defined in.
```

The directives to remove are: 

```scss 
 *= require_tree .
 *= require_self
```

And outside of the comment block, we import our sass file. 

```scss 
@import 'base';
```

We use quotes around the file to be imported and a `;` to finish the statement, similar to css statements.

Let's start up our browser and navigate to the root to see our BEAUTIFUL CSS!

#### Base Styles

Right off the bat, we created a `base.scss` that is holding all our code. We want to make this a partial that can hold all base styles for your site. If you get more into SCSS functionalities, you can use this partial to store mixins and extensions as well.

This is a great place to store color and font variables and mixins that are used throughout the application.

Let's put font colors and font type there. We want to use a new "fun" font!

```scss
/* assets/stylesheets/base.scss */

@import url('https://fonts.googleapis.com/css?family=Joti+One');

$fun-font: 'Joti One', cursive;

$indigo-header: #3D348B;
$other-black: #191716;
$mustard: #E6AF2E;
$lighter-gray: #E0E2DB;
$darker-gray: #BEB7A4;

```
#### Skeletal styles

Let's create another file in the same directory called `skeleton.scss` and place our rules in that file. 

If all of our sections of the site we're building are sharing consistency among element names, consistency is assumed among styling for these elements.

We also need to import the file in our manifest file. Since the manifest file serves as the compiled css file, information will get compiled in the order it is imported and therefore, `skeleton.scss` will know about `base.scss`.

Our manifest file should look like this:

```scss 
@import 'base';
@import 'skeleton';
```

And `skeleton.scss`:

Let's use the `fun-font` at 50px and gather all of this into an SCSS partial.

```scss
/* assets/stylesheets/skeleton.scss */

$custom-border: 3px dotted $mustard;

h1 {
  font: {
    family: $fun-font;
    size: 50px;
  }
  color: $indigo-header;
  background-color: $lighter-gray;
}

h2 {
  color: $maroon;
}

p {
  font: {
    family: papyrus;
    size: 30px;
  }
}

.movie-index {
  h1 {
    color: $darker-gray;
  }

  .movie-show-link {
    text: {
      align: center;
      decoration: line-through;
    }
  }

  p {
    border: $custom-border;
  }
}
```

### Partials 

As stylesheets grow, mantainability becomes a concern. To alleviate this, we can use partials.

If a scss file requires another scss file, the necessary scss files will need to be imported before the scss file it is required in. 

A general rule of thumb is **import in order of least specific to most specific**. This way, if base styles need to be overridden, they can be within their individual section.

#### Sections

This would allow me to, at any moment, easily find and update the styles associated with a specific section. Let's pull the `movie-index` code into another file. 

```scss 
/* application.scss */

@import 'base';
@import 'skeleton';
@import 'sections/movie_index';
```

```scss
/* assets/stylesheets/sections/_movie-index.scss */

$custom-border: 3px dotted $mustard;

.movie-index {
  h1 {
    color: $darker-gray;
  }

  .movie-show-link {
    text: {
      align: center;
      decoration: line-through;
    }
  }

  p {
    border: $custom-border;
  }
}
```

#### Global Components

We've got our base skeleton's styles extracted. We've got an organized space for each section of our site's extracted styles. What about the styles that are still being shared among our site?

Remember, we want our SCSS to be as DRY as possible.

Consider the following possibly global components you'd have across your site:

- Buttons
- Navbars
- Hamburger menus

Creating a separate SCSS partial for each of these makes our code immensely more modular. So modular, in fact, that you could reuse these partials among other sites you build with a simple drag/drop and aligning of element/class names.

#### See What Feels Right for Your Site

This cascade of partials may not be immediately implementable for your site. You may even think of another way of organizing your styles. However, with the above, you'll have:

- Skeletal styles extracted into one place
- Section partials with styles specific to that section
- Global components defined in one place

### More SASS syntax

#### Using `@extend`

- Let's take a small example from `movie_mania` to demonstrate how to use `@extend`. We want both our `h2`'s on all pages and `p` tag on the `movie-index` to both be `$maroon`. Using `@extend` is similar in Sass as it is in Ruby classes. It allows the tag that holds the `@extend` rule to inherit the rules of the class/id/basic selectors.

```scss

$custom-border: 3px dotted $mustard;

.movie-index {
  h1 {
    color: $darker-gray;
  }

  .movie-show-link {
    text: {
      align: center;
      decoration: line-through;
    }
  }

  p {
    border: $custom-border;
    @extend h2;
  }
}

```

- Now our `p` inherits the same `$maroon` color as the `h2` tags and we don't have to repeat ourselves. But what else did this do? What changes do we see?
- Fun Fact: A selector can use more than one extend!

#### Mixins  

- Mixins allow you to define styles that can be re-used throughout the stylesheet. Think about this similarly to a function or method that is reusable.
- Let's say that we want to reuse this piece of code that right now applies to all `h1` tags:

```scss 
font: {
    family: $fun-font;
    size: 50px;
  }
  color: $indigo-header;
  background-color: $lighter-gray;
```

- Let's add a mixin to our `base.scss` file, where it will be accessible to the files below it (based on `@import` statements).

```scss
// base.scss

@mixin big-info {
  font: {
    family: $fun-font;
    size: 50px;
  }
  color: $indigo-header;
  background-color: $lighter-gray;
}
```

A mixin is define by an `@mixin` followed by the name of the mixin and `{}`.

And to use it in our `skeleton.scss` file or any other file, we need to use `@include` in our rules:

```scss
h1 {
  @include big-info;
}

h2 {
  color: $maroon;
}

p {
  font: {
    family: papyrus;
    size: 30px;
  }
}

```

#### Mixins with default arguments

What if we want some of the information in a mixin to dynamically change? We can use arguments with our mixins to acheive this. Let's change up our `h1` on our `movie-index` to be a little different than the other `h1`'s. We want it to be `40px`, a font family of `gill sans` and the color `#276360`. We also need to adjust our `h1` in the `skeleton.scss` file.

```scss 
# base.scss 

@mixin big-info($font, $size, $color) {
  font: {
    family: $font;
    size: $size;
  }
  color: $color;
  background-color: $lighter-gray;
}
```

```scss 
# skeleton.scss

h1 {
  @include big-info($fun-font, 50px, $indigo-header);
}

h2 {
  color: $maroon;
}

p {
  font: {
    family: papyrus;
    size: 30px;
  }
}
```

```scss
# movie-index.scss
  
$custom-border: 3px dotted $mustard;

.movie-index {
  h1 {
    @include big-info('gill sans', 40px, #276360)
  }

  .movie-show-link {
    text: {
      align: center;
      decoration: line-through;
    }
  }

  p {
    border: $custom-border;
    @extend h2;
  }
}
```

## Wrap Up Questions

* What does Sass stand for?
* Why is Sass a better option than CSS?
* How is a variable declared and assigned in Sass?
* Why is nesting a benefit? Both at an element and property level?
* How is a mixin declared and assigned in Sass?

### Resources

* Read the [Sass docs](http://sass-lang.com/guide) :D

### Ready for More?

* Create separate stylesheets for **typography** (all things related to fonts on your page), **colors**, etc.
* Save common settings like `border`, `margin`, and `line-height` to variables in base.scss
* Read the [Sass docs](http://sass-lang.com/guide) :D
* Use the built in Sass methods such as `lighten`.
