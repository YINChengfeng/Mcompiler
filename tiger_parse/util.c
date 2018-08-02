/*
 *  * util.c - commonly used utility functions.
 *   
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"
void *checked_malloc(int len)
{
	void *p = malloc(len);
	if (!p) {
		fprintf(stderr,"\nRan out of memory!\n");
		exit(1);
	}
	return p;
}

string String(char *s)
{
	int len = strlen(s);
	string p = NULL;
	if (s[0] == '\"' && s[len - 1] == '\"')
	{
		p = checked_malloc(len - 1);
		memcpy(p, s + 1, len - 2);
		p[len - 2] = '\0';
	}
	else
	{
		p = checked_malloc(len + 1);
		strcpy(p, s);
	}

	//string p = checked_malloc(strlen(s)+1);
	//strcpy(p,s);
	return p;
}

U_boolList U_BoolList(bool head, U_boolList tail)
{
	U_boolList list = checked_malloc(sizeof(*list));
	list->head = head;
	list->tail = tail;
	return list;
}
