import pandas as pd 
import numpy as np 
import mysql.connector
import time
import matplotlib.pyplot as plt
import datetime
import logging
import sys
import mysql


pd.set_option('display.width', 2000)
pd.set_option('display.max_columns', 50)
starttime = datetime.datetime.now()
logging.basicConfig(level=logging.INFO, filename=sys.argv[0].split('.')[0]+'.log')

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="",
  database="stackoverflow2010"
)

logging.info("Starting to retreive data ... Time passed %s", (datetime.datetime.now()-starttime))
users = pd.read_sql_query("select id, accountid, reputation from users", mydb);
posts = pd.read_sql_query("select id, answercount, unix_timestamp(creationdate) as creationdate, owneruserid, parentid, posttypeid from posts", mydb)
posts['creationdate'] = posts['creationdate'].apply(lambda t: datetime.datetime.fromtimestamp(t))
logging.info("Data retrieved ... Time passed %s", (datetime.datetime.now()-starttime))

# data = None

"""
Attach reputaion with posts
1) Merge posts with users.
"""

posts = pd.merge(posts, users[['accountid', 'reputation']], how='left', left_on='owneruserid', right_on='accountid')
posts['reputation'] = posts['reputation'].dropna()
print(posts['reputation'].isna().sum())
"""
Start filtering posts.
1) Get all question with at least one answer.
2) Get all answers.
"""
questions = posts[(posts['posttypeid'] == 1) & (posts['answercount'] > 0)] 
logging.info("Total questions found %s", questions.shape)
answers = posts[posts['posttypeid'] == 2]
logging.info("Total answers found %s", answers.shape)







"""
Merge questions ans answers to perform comparisons.
1) Remove all answers after 30 days of question time.
"""
qa = pd.merge(questions, answers, how='left', left_on='id', right_on='parentid', suffixes=['_q', '_a'])
qa['delay'] = (qa['creationdate_a']-qa['creationdate_q']).astype('timedelta64[s]') # Getting the delay time
qa['timerank'] = qa.groupby('id_q')['delay'].rank(method='dense')

q1 = qa[qa['answercount_q'] == 1]
print("q1", q1.shape)
q2 = qa[qa['answercount_q'] == 2]
print("q2", q2.shape)
q3 = qa[qa['answercount_q'] == 3]
print("q3", q3.shape)
q4 = qa[qa['answercount_q'] == 4]
print("q4", q4.shape)
q5 = qa[qa['answercount_q'] == 5]
print("q5", q5.shape)
# plt.plot(q2['reputation_a'])
# plt.show()
q1_medians = q1[['reputation_a', 'timerank']].groupby('timerank')['reputation_a'].median()
q2_medians = q2[['reputation_a', 'timerank']].groupby('timerank')['reputation_a'].median()
q3_medians = q3[['reputation_a', 'timerank']].groupby('timerank')['reputation_a'].median()
q4_medians = q4[['reputation_a', 'timerank']].groupby('timerank')['reputation_a'].median()
q5_medians = q5[['reputation_a', 'timerank']].groupby('timerank')['reputation_a'].median()
print(q1_medians)
print(q2_medians)
print(q3_medians)
print(q4_medians)
print(q5_medians)

# q1.to_csv('q1.csv', index=False)
# data.to_csv('fig1.csv', index=False)
# print('done')
# qa['answertimegap_seconds'] = qa.sort_values(['id_q', 'delay']).groupby('id_q')['delay'].diff().astype('timedelta64[s]')
# qa['answertimegap_seconds'] = qa['answertimegap_seconds'].fillna(qa['delay'].astype('timedelta64[s]'))
# stats = qa[['id_q', 'answertimegap_seconds']].groupby('id_q', as_index=False).agg({'answertimegap_seconds':['mean', 'median', 'min']})
# stats.columns = ['id', 'mean_answertimegap_seconds', 'median_answertimegap_seconds', 'min_answertimegap_seconds']
# stats = pd.merge(stats, qa[['id_q']], how='left', left_on='id', right_on='id_q')
# stats = stats.drop(columns=['id_q']).drop_duplicates('id')


"""
Get everything with max score
1) sort qa and drop duplicates
"""
# max_score_row = qa.sort_values('score_a', ascending=False).drop_duplicates(['id_q'])[['id_q', 'delay', 'timerank']]
# max_score_row.columns = ['id', 'max_score_answer_wall_clock_arrival', 'max_score_timerank']
# max_reputation_row = qa.sort_values('reputation_a', ascending=False).drop_duplicates(['id_q'])[['id_q', 'delay', 'timerank']]
# max_reputation_row.columns = ['id', 'max_reputation_answer_wall_clock_arrival' ,'max_reputation_answer_timerank']

# # """
# # Final Merging
# # """
# data = pd.merge(max_score_row, max_reputation_row, how='left', on='id')
# data = pd.merge(data, stats, how='left', on='id')
# data = data.sort_values('id')

# print(data.iloc[:5,:])

# logging.info("All query complete ... Time passed %s", (datetime.datetime.now()-starttime))



# logging.info("Data saved to file, done... Time passed %s", (datetime.datetime.now()-starttime))