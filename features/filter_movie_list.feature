Feature: display list of movies filtered by MPAA rating
 
  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page
  
Scenario: restrict to movies with 'PG' or 'R' ratings
  # enter step(s) to check the 'PG' and 'R' checkboxes
  When I check the following ratings: PG,R
  # enter step(s) to uncheck all other checkboxes
  When I uncheck the following ratings: PG-13,G 
  # enter step to "submit" the search form on the homepage
  When I press "ratings_submit" 
  # enter step(s) to ensure that PG and R movies are visible: 'The Terminator','When Harry Met Sally','Amelie','The Incredibles','aiders of the Lost Ark'
  Then I should see items with the following categories: PG,R 
  # enter step(s) to ensure that other movies are not visible		 
  Then I should not see items with the following categories: PG-13,G 

Scenario: no ratings selected
  # see assignment
  # enter steps to chech all movies
  When I uncheck all the ratings
  # enter steps to submit
  When I press "ratings_submit" 
  # enter expected result
  Then I should see none of the movies  

Scenario: all ratings selected
  # see assignment
  # enter steps to chech all movies
  When I check all the ratings
  # enter steps to submit
  When I press "ratings_submit" 
  # enter expected result
  Then I should see all of the movies  
