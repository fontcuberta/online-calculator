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
