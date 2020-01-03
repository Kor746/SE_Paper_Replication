import matplotlib.pyplot as plt
import pymysql
import numpy as np
import datetime
import pandas as pd


def get_answer_delay():
	figure1_delay_dict = {}
	conn = None
	loopback = '127.0.0.1'
	conn = pymysql.connect(host=loopback, unix_socket='/tmp/mysql.sock', user='root',password=None, db='stackoverflow2010')
	cur = conn.cursor()
	cur.execute("""SELECT p.Id as Question, a.Id as Answer, a.OwnerUserId AS User_Id, TIME_TO_SEC(TIMEDIFF(a.CreationDate,p.CreationDate)) AS AnswerDelay
				FROM Posts as p INNER JOIN AnswerView as a ON p.Id = a.ParentId
				WHERE p.PostTypeId = 1 
				AND a.PostTypeId = 2
				AND p.AnswerCount = 3
				GROUP BY Question, Answer
				ORDER BY Question, AnswerDelay ASC;"""
				)
	df = pd.read_sql_query("""SELECT p.Id as Question, a.Id as Answer, a.OwnerUserId AS User_Id, TIME_TO_SEC(TIMEDIFF(a.CreationDate,p.CreationDate)) AS AnswerDelay
				FROM Posts as p INNER JOIN AnswerView as a ON p.Id = a.ParentId
				WHERE p.PostTypeId = 1 
				AND a.PostTypeId = 2
				AND p.AnswerCount = 3
				GROUP BY Question, Answer
				ORDER BY Question, AnswerDelay ASC;""",conn)
	for row in cur:
		# print(row[0])
		if figure1_plot_dict.get(row[0]) is None:
			figure1_plot_dict[row[0]] = []
		figure1_plot_dict[row[0]].append((row[1],row[2],row[3]))
	cur.close()
	conn.close()
	return figure1_plot_dict

def get

def main():
	figure1_plot_dict = get_answer_delay()
	print(figure1_plot_dict)
	get_user_reputation(figure1_plot_dict)
	# for row in cur:
	# 	if figure1_plot_dict.get(row[0]) is None:
	# 		figure1_plot_dict[row[0]] = [row[2],row[3].seconds]
	# 	figure1_plot_dict[row[0]].append([row[2],row[3].seconds])
	# print(figure1_plot_dict)




if __name__ == '__main__':
	main()

