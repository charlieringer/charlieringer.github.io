# Who or What is a Neural Network (A Primer) - A Beginner's Guide to Deep Learning Part 0
###### Topics: Machine Learning, Beginner's Guide. Audience: Beginner. 
Welcome to the first in a blog series where I aim to take you, the reader, from someone who knows nothing about Deep Learning to someone who is comfortable implementing Deep Learning models to tackle a range of problems. Most importantly I want to you to come away with an understanding of *why* certain Deep Learning techniques work for certain problems and enable you to intelligently construct your own models for a specific problem you have. Each blog post will cover a different topic, starting with the conceptual Neural Network building blocks and then moving on to more complicated ideas such as the very buzzwordy Generative Adversarial Networks (GANs). 

Starting with part one I will first explain the concept at hand and then provide a code walkthrough (in Python) and GitHub repository for you to get hands dirty with and try stuff out. However, for this blog, I am going to do something different and instead give you a primer about what Deep Learning and Neural Networks are so that by the time you have finished reading you will have all of the machine learning knowledge you need for the rest of the series.

Throughout this blog series, I am going to shy away from giving a detailed description of the maths involved with Deep Learning, and instead, I aim to provide the *intuition* behind what certain algorithms are doing. When I started my journey into Deep Learning my supervisor rarely discussed the maths in detail, instead, I focused on explaining intuition which I found really helped me to get an understanding of what was happening inside the network. Hopefully, I can pass this understanding on to you!

## Learning Outcomes
By the end of this blog you will:

- Understand broadly what machine learning is and the difference between Supervised, Unsupervised and Reinforcement Learning
- Understand how a simple neural network works 
- Know what makes deep leaning 'deep'

## Assumptions
While this is a beginner guide there are a few assumptions I am going to make about who is reading this: 

- Firstly, I am going to develop all of the code in Python and so am assuming at least a basic level of programming ability and, ideally, knowledge of Python. I will be providing full source code with each blog post so you can still run the code if you are unsure how it works.  
- Secondly, while I am going to deliberately omit detailed discussion of the maths behind Deep Learning there is still going to be some maths. Therefore a basic understanding of Linear Algebra will help a lot. Not worry about this too much, I have not studied Maths formally since I was 16, other than a very rudimentary course during my undergraduate but I found Machine Learning so fascinating that I have learnt 'on the job' and hopefully I can inspire you to do this as well.

## What is a Neural Network?
Good question. But first, we need to answer the question 'What is Machine Learning'. Here is my personal definition of what Machine Learning is:

**Machine Learning is learning an approximate mapping (f) of data (x) to labels (y). Put another way it is learning the function f where f(x) ≈ y.**

Ok, let's break that down. In this case, our data (x) can be pretty much anything, as long as it is numeric (because computers *love* numbers) or can be converted into numbers (but more on this as and when we encounter these cases). Our labels (y) are what we want the system to be able to predict. To provide a very simple example let's say we have a plant we are watering regularly and we want to be able to predict how much will grow after some number of days. We take observations every day, including day 0 when we start -> `x = {0, 1, 2, 3, 4}` and we measure how much it has grown (our label) -> `y = {0, 2, 4, 6, 8}`. From this, we can see that the relationship between x and y is `y = x\*2`, so our mapping would be `f(x) = x*2`. This means that we can predict that after 5 days the plant will have grown 10 and after 6 days it will have grown 12 etc. Naturally this toy example is incredibly easy to figure out so we don't need machine learning but imagine that instead of a single input (observation time) we looked at moisture, sunlight levels, ph balance of the soil, type of plant etc. it becomes clear why it is attractive to use a computer to figure out this mapping. 

This is the essence of Machine Learning - given some data and something we want to know let's learning the mapping between data and label so that in the future if we just have data we can predict the label. This mapping function `f(x)` is known as a 'model' because it is a model of a certain part of the real world, it does not perfectly replicate the real world but merely represents it as best as possible. This model can take numerous forms however this set of blog posts were are going to focus only on Neural Networks. There are also numerous ways to 'train' Neural Networks but we are only really going to be focusing on one method - Gradient Descent. Gradient Descent is the most popular method for training Neural Networks but I don't plan on going into it in any detail because it is a fairly dry and maths heavy topic. All you need to know is that by running many iterations of the training (known as 'epochs') the network will slowly learn the best mapping between data and labels. 


## Supervised vs Unsupervised vs Reinforcement Learning
The eagle-eyed among you (or, those with some prior Machine Learning knowledge) will realise that actually what I described above is not all machine learning but in fact, a particular branch, known as **Supervised Learning**. Supervised Learning (so-called because we know both the data and the labels so can supervise the whole learning process) is the probably most popular method for machine learning and as such will be the bulk of the topics covered in this guide, however, for completeness I am going to briefly discuss the differences between the different paradigms. Don't worry, I will go into detail about Unsupervised and Reinforcement learning when I write blogs about them.  

- **Supervised Learning:** We have *data* as well as *labels*. We want to be able to learn a mapping between to two so that when we get new data we can estimate the label.
- **Unsupervised Learning:** We have *data* but *no labels*. Instead of learning a mapping between data and labels we learn patterns within the data itself. Unsupervised learning can be very powerful but its applications are not as straightforward as supervised learning. We will return to unsupervised learning later in this series. 
- **Reinforcement Learning:** We have *no data* and we have *no labels*. But we have an environment which the algorithm can interact with (think a robot in a room) and we know when the algorithm does something 'good'. We are trying to learn to maximise taking 'good' actions. 

## So ... What is a Neural Network?
Good question and one we are now equipped to answer. Here is the most simple version of a neural network:

![The most simple version of a neural network](../images/blog_002/perceptron.png)

This diagram is the same as writing o1 = f(i1, i2, i3) = activation(i_1\*w1 + i2\*w2 + i3\*w3) where each weight (w1, w2, w3) are what we learned during the training process and the activation is a specifically chosen function that we will talk about in detail in the next section, all you need to know is that it is is a function of the sum of the weights that feed into it. This type of neural network is known as a perceptron, and here it has 3 input values and one output target. These types of networks are rarely used these days as they are too simple, in reality, a neural network consists of many more layers this will cause the long form, written out version of the network to get very unwieldy fast, e.g.:

![A slightly more complicated network with 21 weights](../images/blog_002/mlp.png)

Results in o1 = f(i1, i2, i3) = activation(w19\*activation(w10\*activation(i1\*w1 + i2\*w4 + i3\*w7) + w13\*activation(i1\*w2 + i2\*w5 + i3\*w8) + w16\*activation(i1\*w3 + i2\*w6 + i3\*w9)) +  w20\*activation(w11\*activation(i1\*w1 + i2\*w4 + i3\*w7) + w14\*activation(i1\*w2 + i2\*w5 + i3\*w8) + w17\*activation(i1\*w3 + i2\*w6 + i3\*w9)) +  w21\*activation(w12\*activation(i1\*w1 + i2\*w4 + i3\*w7) + w15\*activation(i1\*w2 + i2\*w5 + i3\*w8) + w18\*activation(i1\*w3 + i2\*w6 + i3\*w9)))

As you can see things get complicated very quickly, especially when you consider that this network has only 21 weights, modern networks have hundreds of thousands or millions (or even billions in rare cases) of weights. Therefore it is usually better to think about networks by its structure, or *architecture*. Here each circle as called a *neuron* and each column from left to right is called *layer* and layers in the centre of the network which are not inputs or outputs are known as 'hidden' as they are contained within the model itself. Therefore we can say that this network about has 2 'hidden' layers with 3 neurons each, this style of neural network is known as a 'multi-layer perceptron'.

## Activation functions
Hopefully, at this point, you will have a reasonably good idea how a network takes a set of input values (i1, i2, i3) and calculates a prediction for the output (o1) except for the what goes on at each neuron. Inspired by neuroscience at each neuron we take the 'signal' being passed from the previous layer and sum all of these, then in order to calculate what signal should be passed forward the neuron takes this summation and apply a 'non-linear' function to it. Two such functions are the most commonly used so let's talk about those now, I will introduce other if we need them.

#### Sigmoid
Sigmoid was, for a long time, the most common activation function and has a few really handy properties, like the fact at all outputs are bounded between 0 and 1, so if you are training a model to differentiate between two things you can give thing 'a' the label '0' and thing 'b' the label '1' then Sigmoid the output and choose some threshold (say, 0.5) - anything where the Sigmoid is < 0.5 is predicted as label 'a' and anything with Sigmoid > 0.5 is label 'b'. Sigmoid also has some really nice properties when it comes to actually training the network but since we are not going into detail about how that works here it is not worth explaining them. Sigmoid has the form:


![Sigmoid (Source: Wikipedia)](../images/blog_002/sig.svg)

#### ReLU
Sigmoid can have issues with learning, especially when you have a lot of input values, as is common in something like an image processing task where each pixel is the original images represents 3 input values (RGB) meaning that for a 1080x720 pixel images you have over 2 million inputs. Therefore ReLU is very commonly used, especially in the hidden layers, as it handles these cases better. ReLU is short for 'Rectified Linear Unit' and is much simpler than Sigmoid. ReLU has the form:

![ReLU (Source: Wikipedia)](../images/blog_002/relu.svg)

Put another way, if the sum of the incoming signals is >= 0 do nothing but if it is negative just set it to 0. 

#### Other Activation Function
As mentioned above these two are used in 99% of cases however if you are interested or wish to have a useful reference I really recommend the Wikipedia page on Activation Functions [Activation Functions](https://en.wikipedia.org/wiki/Activation_function "Activation Functions") as it is surprisingly useful and well put together. 

## What makes Deep Learning deep?
The last question to answer in this post is what makes Deep Learning 'deep'. This is a question which is both simple and complex. Simply, a deep neural network is any network which has more than one hidden layer, e.g. the multi-layer perceptron above, with the theory that each extra layer adds the ability to learn more 'high level' values relating to the relationship between inputs and thus improve results. However, this definition is a little dated given that the recent increases in computation power means that these days even the most simple networks often have many layers. The slightly more complicated answer then is that these days deep learning is used for neural networks which are doing something more complicated/interesting than the basic networks described above. We will go into detail about what types of complicated things you can do in later blogs but they include things such as given the network the ability it understands spatial data (e.g. images) or temporal data (e.g. a persons heart rate over time). 

## Let's get practical (sorta)
Ok, enough background, let's get set up. This has been a whirlwind introduction to the topic, there is a lot more under the surface that I don't have time to talk about, if you are interested I absolutely urge you to seek out other writers on this topic. For now, we are going to set up our Keras environment and make sure everything is working ready to get into training some models next week. 

The first thing we need to do is to make sure we have the correct version of Python installed. This blog series will use Python 3 rather than Python 2 but if you are experienced as a python programmer and more comfortable with Python 2 then there is no real reason why you can't use it, but the code is likely to need modification in order for it to run. The other key thing to know is there have been some issues with Tensorflow when using python 3.7 although it is possible that these are resolved now. The version of Python I have installed on my PC is 3.6.3 so if you have that these tutorials will work, if you are using another version then they will probably work but there is a chance there you may run into slight bugs down the line. The best place to get hold of Python if you need to install it is the [Python website](https://www.python.org/ "Python website"). 

Once you are up and running with Python (make sure you can call it from your command line shell of choice) we need to install Keras which can be done with `pip install keras` from your shell (Note: if you have both Python 2 and Python 3 installed on your computer you might need to call `pip3` if you want to install the Python 3 version). Keras is dependant on Tensorflow so will install Tensorflow, Tensorflow GPU and all of the other necessary packages. It should also install Numpy for you (an awesome numerical library for Python) but if it does not then you might need to install that as well with `pip install numpy`. We will also certainly need Pandas, a really handy tool for handling data sets, so install that with `pip install pandas`. That should be everything for now, I will let you know if anything else we need as we go along. 

Side note: If you are not used to doing too much command line stuff don't worry too much, I will make sure all of the commands you need are clear here. If you are on Mac or Linux I recommend using the default install terminals (called Terminal in macOS, and it varies by distro in 'nix). If you are Windows then I highly recommend using Powershell (my personal go to on Windows) or git bash over Command Prompt. 

Once everything is installed let's check to see if everything is installed correctly. Make a new script and call it what you wish when writing the following code where we import the newly installed packages and then print the currently installed version:

```
import keras
import tensorflow
import numpy as np
import pandas

print("Keras version {}".format(keras.__version__))
print("TF version {}".format(tensorflow.__version__))
print("Numpy version {}".format(np.__version__))
print("Pandas version {}".format(pandas.__version__))

print("Everything imported ok")

```
 If that all worked out you should get an output like:

```
Keras version 2.2.4
TF version 1.14.0
Numpy version 1.16.3
Pandas version 0.21.1
Everything imported ok
```

If this all ran ok then we are set up for future blogs. Sorry, we are not going to get to training any models in this post, consider this a cliff hanger for next time! 

## Key Terms
Below is a list of key terms that you can refer to if you forget what something means (totally understandable, there are a lot of new terms introduced in this blog)

- Model - The learnt mapping between inputs and outputs
- Training - The process of learning the mapping from inputs to outputs
- Machine Learning - The overarching term for developing, training and then potential deploying a model 
- Neural Network - A particular type of model inspired by neuroscience
- Deep Learning - Machine Learning using more complex Neural Networks architectures
- Epoch - A single training pass through the data set
- Supervised Learning - Training when we have both inputs and outputs
- Unsupervised Learning - Training when we have only inputs
- Reinforcement Learning - Training when we have no data at all, but we have the ability to generate it by interacting with an environment
- Data - The inputs to the network, can be pretty much anything
- Labels - The expected output of the network 
- Neuron - A part of the network which sums incoming signal, applies an activation and the passes the result forward to the next layer
- Layer - A set of neurons connected to other neurons/inputs/outputs
- Activation function - A non-linear function which is applied at each neuron. Most common two are Sigmoid and ReLU
