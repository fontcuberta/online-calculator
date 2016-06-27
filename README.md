The online calculator
=====================

Introduction
------------

We are in the Internet era, so everything has gone or is going online.
We order stuff online, we watch TV shows online, we buy music online,
we even change the world through Twitter...
So why not calculating online?
Does it make sense? (Einstein silently agrees)

It's decided: we will implement a simple calculator
so first grade students can use it from their iPhones during their exams.
I know what you're thinking: "But iOS has a built-in calculator! Are you crazy?"
Well, it definitely does, but **OURS IS ONLINE**!!!
We will make a killing in advertising money.


Iteration #1: Addition
----------------------

Let's kick off our calculator project with the classic math operation: addition.
If one of those 1st graders visits the `/add` route in our application,
they should see two text fields to type numbers into.
You should probably put a plus sign `+` between the text fields
and a heading for the page so those kids don't get lost.
They should also see a button that will compute the addition when it's clicked.
After clicking, they should see a message like:

```
9 + 87 = 96
```

Setup
-----

Since this is a new Sinatra project we should create a new folder.
The first thing we need to do is create the `Gemfile`:

```ruby
# Gemfile
source "https://rubygems.org"

gem "sinatra"
```

Now let's create our `server.rb` with an `/add` route:

```ruby
# server.rb
require "sinatra"

get "/add" do
  erb(:add)
end
```

Next up: our `add.erb` view with the basic HTML structure:

```html
<!-- views/add.erb -->
<!doctype html>
<html>
<head>
  <title>Add | Online Calculator</title>
</head>
<body>
  <h1>Add</h1>
</body>
</html>

```

But wait! This is the Web.
That means our only interface is in HTML.
What should the HTML tags for this simple interface be?
How do we capture a user's input in HTML?


User Input in HTML
------------------

### URLs and clicking ###

Obviously, we can't use `gets` here.
Users are not looking at our Sinatra terminal, they are looking at a Web page.
If you think about it, when a user visits the homepage and clicks on something,
that click is a form of user input.
They are establishing the intention to visit another page.

There are other ways to handle user actions in the browser,
but we will cover those later in the course.


### The `<input>` tag ###

The other typical way to capture a user's input is with the `<input>` tag:

```html
<input type="text">
```

The `<input>` tag shows up as text field in browsers.
It also has a `type` attribute.
By changing the `type` attribute's value,
you are telling the browser what kind of input you are expecting from the user.
The default is `type="text"`, but there are many others.
Here are some common types. Try them out. How do they change in the browser?:

- `type="checkbox"`
- `type="date"`
- `type="datetime"`
- `type="email"`
- `type="file"`
- `type="hidden"`
- `type="number"`
- `type="password"`
- `type="radio"`
- `type="tel"`
- `type="url"`

#### [Try input types on CodePen](http://codepen.io/khalifenizar/pen/qONQZR?editors=100) ####

You should always think about the `<input>` type most apprioriate
for the information you want from the user.
For our calculator, it seems like the `number` type is the most appropriate.
Let's start with two `number` inputs and that plus sign:

```html
<!-- views/add.erb -->
<h1>Add</h1>

<input type="number"> +
<input type="number">
```


### The `<label>` tag ###

Aside from the `<input>` tags themselves,
you also need to give the user an idea of what you are expecting them to input.
In the terminal, you usually would accompany a `gets`
with a `puts` that asks the user a question.

In HTML, there's a special tag for labeling inputs
to give the user more context about each input.
It's the `<label>` tag.
Each `<input>` should normally have a `<label>` associated to it.

```html
<label>Your name:</label>
<input type="text">

<label>Your email:</label>
<input type="email">
```

It's a good practice to not only have a `<label>` for each `<input>`,
but also link them together in the code
with the `for` attribute on the `<label>`.

```html
<label for="name">Your name:</label>
<input type="text">

<label for="email">Your email:</label>
<input type="email">
```

Keep in mind that the `for` attribute of a `<label>`
needs to match the `id` attribute of the `<input>`.
Out inputs don't have the `id` attribute yet, so let's add that.

```html
<label for="name">Your name:</label>
<input type="text" id="name">

<label for="email">Your email:</label>
<input type="email" id="email">
```

This improves the user experience of your inputs
because a user can click the label to interact with that input.
Clicking the label is just like clicking the input!
This is especially important in smaller inputs like `type="checkbox"`,
that are normally much harder to click because of their small size.

```html
<input type="checkbox" id="terms">
<label for="terms">You agree to our not evil terms of service</label>
```

#### [Try labels on CodePen](http://codepen.io/khalifenizar/pen/BozGNP?editors=100) ####

**Pro tip**: Remember the `<label for="">` is linked to the `<input id="">`.
If you change the `for` value you must also change the `id`.

```html
<label for="somethingsomethingsomethingdarkside">Label</label>
<input type="text" id="somethingsomethingsomethingdarkside">
```


### Placeholders ###

Another great thing you could do to give the user more context in your inputs
is add a `placeholder` attribute to the input.
The value of the `placeholder` attribute should be
some text to show while the input is empty.
As soon as the input has real text entered, the placeholder disappears.

```html
<label for="name">Your name:</label>
<input type="text" id="name" placeholder="Han Solo">

<label for="email">Your email:</label>
<input type="email" id="email" placeholder="han@smugglers.sexy">
```

For aesthetic reasons, let's ignore best practices in our calculator
and not have any `<label>` tags.
We should definitely have placeholders though.

```html
<!-- views/add.erb -->
<h1>Add</h1>

<input type="number" placeholder="1st number"> +
<input type="number" placeholder="2nd number">
```


Capturing user input
--------------------

### Two routes for submitting input ###

Now that we know how to present inputs to the user,
the next step is to **capture the input** in our Sinatra application.
Once we have the information provided by the user in our Ruby code,
we can finally perform the addition operation.

What really happens in the Web is that
we treat all those user inputs together as a **form**.
That form needs to be submitted back to our Sinatra app.
The process is nothing fancy: it just makes another HTTP request
to send our Sinatra app the information entered by the user.
It's like dealing with a government office.
They provide services but you need to provide the paperwork
with your information so they can perform the service.

The important thing to remember with forms on the Web is that
there will be two routes in your application that participate in this process.

1. A **GET** route to show the user the form HTML with all the inputs.
2. A **POST** route that receives and processes the information from the form.

It's not _always_ going to be a POST route.
That depends on the action that the information is being submitted for.
But to keep things simple, let's assume it's always a POST for now.


### The `<form>` tag ###

To submit our inputs back to Sinatra,
we still need to add a couple of things to our HTML.
For starters, all of these inputs need to be inside a `<form>` tag.
The `<form>` tag serves two purposes.
First, it **groups up** all the inputs inside it for submission.
Second, it determines the **route to submit** the information to.
Let's see what our `<form>` tag looks like:

```html
<!-- views/add.erb -->
<h1>Add</h1>

<form>
  <input type="number" placeholder="1st number"> +
  <input type="number" placeholder="2nd number">
</form>
```

Our form is grouping our two inputs,
but it still isn't telling the browser which route to submit to.
For our addition operation,
let's submit to a POST route at the `/calculate_add` URL.
We haven't added that route to our Sinatra application yet,
but we can do that later.
Let's fill in that information in the `<form>` tag:

```html
<!-- views/add.erb -->
<h1>Add</h1>

<form action="/calculate_add" method="POST">
  <input type="number" placeholder="1st number"> +
  <input type="number" placeholder="2nd number">
</form>
```

So it's the `action` attribute that determines the **URL we will submit to**,
and it's the `method` attribute that determines the **HTTP verb**
that will be used in the submission.
Browsers can only handle **GET and POST** as methods.

Note that if you don't specify values for the `action` and `method` attributes,
they will assume default values.
The default `method` is **GET**.
The default `action` is **the current URL**.
If you find that your form isn't doing anything,
it might be that it's ending up on the current URL after you submit it.
Remember to fill in your `action` and `method` on your form!


### Submitting the form ###

Now that the `<form>` tag is telling us which route to submit that user data to,
how can we actually submit the form?
You submit the form with a **submit button**.
Clicking the submit button will cause the browser to make the HTTP request
specified by the `<form>` tag.
Let's add a `<button>` tag to act as our submit button.

```html
<!-- views/add.erb -->
<h1>Add</h1>

<form action="/calculate_add" method="POST">
  <input type="number" placeholder="1st number"> +
  <input type="number" placeholder="2nd number">

  <button type="submit">Calculate</button>
</form>
```

As you can see, the `<button>` tag for a submit button needs three things:
1. To be inside the `<form>` tag.
2. To have the `type` attribute equal to `submit`.
3. To have some text inside it that the user will see.

A little known fact: if you press the **return or enter key**
when your cursor is on an input field, that also submits the form.
Problem is that not all users know about this
so you really need the button no matter what.

Either way, having a submit button provides a better user experience because
the button's text can give the user a better idea
of what will happen when they submit.
If it just said _Submit_ or something generic like that,
it may not be as clear as possible what the consequences of submitting are.
This is especially true with monetary transactions.
The user needs to know which form submission is actually going to charge them!

Another little known fact: the submit button itself
can also be considered an input.
You can give the `<button>` tag a `name` attribute just like an `<input>`.
The key thing here is to give it a `value` as well.

```html
<button type="submit" name="btn" value="edit">Edit</button>
<button type="submit" name="btn" value="copy">Make a copy</button>
```

That way you can have many different submit buttons
that might trigger different behavior in the POST route.
In the above example, maybe you are editing something and you want to have
the option to duplicate it instead of changing the existing one.
In the POST route you would check for the `btn` input value.


### Our first post route ###

If you try to submit our form now, you will get Sinatra's default 404 page.
That's because we haven't defined our POST route yet.
Let's do that now.
Remember we decided earlier that the URL should be `/calculate_add`.

```ruby
# server.rb
require "sinatra"

get "/add" do
  erb(:add)
end

post "/calculate_add" do
  # add numbers here
end
```

Any information submitted through a form to our Sinatra app
will be available to use through the `params` hash.
It's the same `params` hash that contains URL parameters.
Let's see what we are working with
by printing out it's contents with the `#inspect` method.

```ruby
# server.rb

#[...]

post "/calculate_add" do
  "Params data: " + params.inspect
end
```

Restart your server and refresh the page.
Notice that the browser prompts you to resubmit the form.
Accept the resubmission and see that we now have... nothing.

```
Params data: {}
```

The hash is empty!
Where did we go wrong?


### Input `name` attribute ###

Well it turns out that we are missing one last attribute in our `<input>` tags.
It only comes up when you want to use the information submitted.
Our inputs need the `name` attribute.

```html
<!-- views/add.erb -->
<h1>Add</h1>

<form action="/calculate_add" method="POST">
  <input type="number" name="first_number" placeholder="1st number"> +
  <input type="number" name="second_number" placeholder="2nd number">

  <button type="submit">Calculate</button>
</form>
```

Without the `name` attribute, these inputs don't submit anything at all!
Go back to your form, refresh the page to get the updated HTML and submit again.

Now we can see the information in the `params` hash:

```
Params data: {"first_number"=>"21", "second_number"=>"21"}
```

Remember, your input's `name` is going to be the key of that input
inside the `params` hash.


### Handling data in `params` ###

Just like with URL parameters, the `params` hash contains the form data.
No matter what, `params` values always start off as strings.
Our inputs here are no exception.
Even though we entered numbers, to Ruby they are considered strings.
Our first order of business is to transform them into numbers.
Let's use the `#to_f` method.
Remember, that's _to float_, as in floating point.
Fancy math term for decimal numbers.

```ruby
# server.rb

#[...]

post "/calculate_add" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  "#{first} + #{second}"
end
```

Now we can just add them together and display the result:

```ruby
# server.rb

#[...]

post "/calculate_add" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  result = first + second
  "#{first} + #{second} = #{result}"
end
```

Boom! Iteration #1 done!


Redirecting
-----------

Remember how when you refreshed the `/calculate_add` page
how you got that _form resubmission_ prompt?
That is literally resubmitting the form to the server.
Sometimes that can be quite problematic.
For example, what if a payment form was resubmitted?
The system might charge you multiple times.

In those situations where you want to avoid people refreshing the page
to resubmit the form,
instead of showing HTML on your POST route
you need to **redirect the user** to another page.
If they refresh that other page it's okay because it will be a GET.

Now, in this exercise we are going to ignore that best practice.
In the future, however, keep in mind
that you basically always redirect after a successful POST request.

To redirect in Sinatra use `redirect to()`.
Here's an example of redirecting to a `/payment_success` route:

```ruby
post "/charge_money" do
  # CHARGE THEM THAT MONEY

  redirect to("/payment_success")
end
```


Online calculator exercise
--------------------------

Now that you've seen the basics of forms on the Web,
it's time to finish our awesome online calculator.


### Iteration 2: Create the basic Calculator ###

Our basic Online Calculator should have a home page (`/`) where you see all four available operations: add, substract, multiply and divide. Pretty simple stuff.

For each one of the available operations, we will have a form with two input fields and a button, which will go to another URL/route and display the result, like “The multiplication of 4 and 15 is 60” or “The addition of 10 and 39 is 49".

You should keep the main controller separated from the logic and the views, putting them in their corresponding folders.

For example, creating a `Calculator` class inside the `lib/` folder could be a great idea. There you could create all the methods in charge of the mathematical operations, freeing the main controller of all the logic that doesn't concern it.

This way, for each route you define related to the Calculator you should only create a new instance of the class and use the basic methods you have defined.

So now it's your turn. Take the forms for each operation, assign them a route in the controller and create the view where the result will be display.

And for now we recommend you to don't spend your time in making it to look nice. We have many iterations ahead, a lot of funcionalities to implement, and clean code to write. Don't worry. We will have plenty of time in the future to make pretty things.


### Iteration 3: Only one form ###

Real calculators don't have different forms for each operation. Having a single form with two input fields and four buttons, one for each operation, would be closer to reality. Think a second about how we could implement it.

If nothing comes to your mind, here is a little hint.

```html
<button type="submit" name="operation" value="addition">ADD</button>
```

The button has two attributes that are really useful: `name` and `value`. When we click on the button, it will submit the value we have set associated with the name inside the params. Then you could take care of the selection of the corresponding operation in the controller.
```ruby
operation = params["operation"] # => "addition"
```


### Iteration 4: Add a memory feature ###

Because we have the power of the Internet behind us (something the iOS Calculator cannot say...) let's use it in our favor. We are going to add a memory feature that will make our application a master piece.

Sadly, we have a problem... Right now our back-end senior developer is working in the database that will store all the calculations our users are going to do. This is a really complex task that is going to take him many days. And time is running out, so we can't wait until he is finished.

For the moment we will be storing the data of our users in a file inside the `public` folder.

You will have to create a button on the result page and store the result to use it later as the first number of the next operation.


### Iteration 5: Other cool (and maybe useless) features ###

While the senior developer is working on the database, here you have a list of possible features you could implement.
* Add a nice logo (search it in Google, we don't have money to pay a designer).
* Functionality to check the hour in other places like New York, Tokyo, Moscow... (use the parametrized routes)
* Counting functionality: the user enters a number and the Calculator should display all numbers from 1 to the entered number, one number per line.
