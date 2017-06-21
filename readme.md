### Reimburse project

#### A few rules:
* First day and last day of a project, or sequence of projects, is a travel day.
* Any day in the middle of a project, or sequence of projects, is considered a full day.
* If there is a gap between projects, then the days on either side of that gap are travel days.
* If two projects push up against each other, or overlap, then those days are full days as well.
* Any given day is only ever counted once, even if two projects are on the same day.
* A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
* A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
* A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
* A full day is reimbursed at a rate of 85 dollars per day in a high cost city.

#### Given the following sets of projects, provide code which will calculate the reimbursement for each.

* Set 1:
  * Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15

* Set 2:
  * Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
  * Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15 same day as first day in subsequent project so which city wins for rate? Right now the city for the closing project is used.
  * Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15

* Set 3:
  * Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
  * Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15
  * Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15

* Set 4:
  * Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15 assuming when multiple projects, the first day of the first project and the last day of the last project are travel days, not each project's first and last day
  * Project 2: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
  * Project 3: High Cost City Start Date: 9/2/15 End Date: 9/2/15
  * Project 4: High Cost City Start Date: 9/2/15 End Date: 9/3/15

### Implementation strategy

I used basic Ruby. I could have used Rails and created models for Project, City, and Itinerary. With Rails migrations and then populate with seeds. And the retrieval of Projects into Itineraries via ActiveRecord queries versus manual population with initialize. But that would have been overkill and very noisy. Then too, had I done that, I couldn't have stopped myself from doing an HTML-based invoice if not a Prawn PDF and that would get crazy.

I also slapped all the classes into one file. This is not something I normally do but, for the purposes of this exercise, with mini-classes, it was easier to write and easier to read with them all in one file. I certainly used TDD for this project because I needed feedback on what I was writing. If you look at the git history you can see my developmental process as there are a dozen commits.
