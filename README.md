<h1>Spending_Habit_Reader</h1>

<h3>Objective:</h3>
To build a time series module to properly predict someone's monthly spending habits, (example the percentage of money spent on essentials, bills, and non essentials), while also keeping note of regular outliers such as birthdays or yearly renewals, which will be based on credit/debit card estatments of the past months.<br>
If time permits it, add more members to be analyzed, and create a group objective model to see what a group mindset could look like, and finally build comparison models that would meet ideal habits one could wish to achieve, wether from other peoples spending habits or one bulit soley on personaslised numbers

<h3>Hypothesis:</h3>
Looking at my objective I worry about the quantity of data I'll have at my disposal I fear that for an individual it may not be enough, although I myself have been able to predict my personal spending habits with the data I have so I look forward to being surprised.<br>
If my hypothesis is correct, though I would not consider this a failed model just yet, as I also suspect that it would be due to missing time data, which can be provided with time<br>
If this is the case that presents its self I will then shift my attention to preparing my models for the data that will eventually be presented

<h3>Time organizer:</h3>
Official start date: <b>April 19</b><br>
Official end date: <b>May 22</b><br>
Time available: <b>4 weeks and 5 days</b>
<h4>4 week plan:</h4>
<ul>
  <li>
    <b>Week 1</b>: 
    collect data by using Tesseract OCR (if collection of data is too difficult we will use some of the 5 day buffer to just use the CSV files from the banks should be doable in a day or two)
  </li>
  <li>
    <b>Week 2-3</b>: cleaning and setting up categories for all titles (if cleaning is done quickly, add new data from other people to project)
  </li>
  <li>
    <b>Week 3-4</b>: create a time series model (if model is done quickly create models from others data and compare habits between all habits)
  </li>
</ul>
With whatever time remains, use it in analyzing patterns or any information that can be taken and formulate it into a document (create a report) and deployment!!!!<br>

<h3>Procedure/tasks:</h3>
<h4>Week 1 collecting:</h4>
<ol>
  <li>
    1) Collect as many estatments as possible
  </li>
  <li>
    2) Use OCR to read said estatments
  </li>
  <li>
    3) Locate descriptors on json file
  </li>
  <li>
    4) Turn into a data frame containing (expense, description)
  </li>
  <li>
    5) Either merge all files into one df with a time column, or export all dfs per month-year
  </li>
</ol>
