--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.13
-- Dumped by pg_dump version 9.6.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: opname; Type: TABLE; Schema: public; Owner: energie-admin
--

CREATE TABLE public.opname (
    id integer NOT NULL,
    tijd timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.opname OWNER TO "energie-admin";

--
-- Name: TABLE opname; Type: COMMENT; Schema: public; Owner: energie-admin
--

COMMENT ON TABLE public.opname IS 'Een opname van meerdere tellerstanden';


--
-- Name: opname_id_seq; Type: SEQUENCE; Schema: public; Owner: energie-admin
--

CREATE SEQUENCE public.opname_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opname_id_seq OWNER TO "energie-admin";

--
-- Name: opname_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energie-admin
--

ALTER SEQUENCE public.opname_id_seq OWNED BY public.opname.id;


--
-- Name: teller; Type: TABLE; Schema: public; Owner: energie-admin
--

CREATE TABLE public.teller (
    id integer NOT NULL,
    naam character varying(32) NOT NULL,
    naam_kort character varying(16) NOT NULL,
    schaal integer NOT NULL,
    teken integer
);


ALTER TABLE public.teller OWNER TO "energie-admin";

--
-- Name: TABLE teller; Type: COMMENT; Schema: public; Owner: energie-admin
--

COMMENT ON TABLE public.teller IS 'De verschillende tellers';


--
-- Name: teller_id_seq; Type: SEQUENCE; Schema: public; Owner: energie-admin
--

CREATE SEQUENCE public.teller_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teller_id_seq OWNER TO "energie-admin";

--
-- Name: teller_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energie-admin
--

ALTER SEQUENCE public.teller_id_seq OWNED BY public.teller.id;


--
-- Name: tellerstand; Type: TABLE; Schema: public; Owner: energie-admin
--

CREATE TABLE public.tellerstand (
    id integer NOT NULL,
    teller_id integer,
    stand numeric(8,3) NOT NULL,
    opname_id integer
);


ALTER TABLE public.tellerstand OWNER TO "energie-admin";

--
-- Name: TABLE tellerstand; Type: COMMENT; Schema: public; Owner: energie-admin
--

COMMENT ON TABLE public.tellerstand IS 'De stand van een teller';


--
-- Name: tellerstand_id_seq; Type: SEQUENCE; Schema: public; Owner: energie-admin
--

CREATE SEQUENCE public.tellerstand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tellerstand_id_seq OWNER TO "energie-admin";

--
-- Name: tellerstand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: energie-admin
--

ALTER SEQUENCE public.tellerstand_id_seq OWNED BY public.tellerstand.id;


--
-- Name: opname id; Type: DEFAULT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.opname ALTER COLUMN id SET DEFAULT nextval('public.opname_id_seq'::regclass);


--
-- Name: teller id; Type: DEFAULT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.teller ALTER COLUMN id SET DEFAULT nextval('public.teller_id_seq'::regclass);


--
-- Name: tellerstand id; Type: DEFAULT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.tellerstand ALTER COLUMN id SET DEFAULT nextval('public.tellerstand_id_seq'::regclass);


--
-- Data for Name: opname; Type: TABLE DATA; Schema: public; Owner: energie-admin
--

COPY public.opname (id, tijd) FROM stdin;
1	2016-08-27 20:00:00
2	2016-09-12 20:00:00
3	2016-09-18 20:00:00
4	2016-09-20 20:00:00
5	2016-09-25 20:00:00
6	2016-10-02 20:00:00
7	2016-10-15 20:00:00
8	2016-10-21 20:00:00
9	2016-10-23 20:00:00
10	2016-10-26 20:00:00
11	2016-10-28 20:00:00
12	2016-10-30 20:00:00
13	2016-10-31 20:00:00
14	2016-11-02 20:00:00
15	2016-11-05 20:00:00
16	2016-11-07 20:00:00
17	2016-11-11 20:00:00
18	2016-11-12 20:00:00
19	2016-11-16 20:00:00
20	2016-11-20 20:00:00
21	2016-11-23 20:00:00
22	2016-11-25 20:00:00
23	2016-11-28 20:00:00
24	2016-11-30 20:00:00
25	2016-12-02 20:00:00
26	2016-12-04 20:00:00
27	2016-12-05 20:00:00
28	2016-12-09 20:00:00
29	2016-12-13 20:00:00
30	2016-12-16 20:00:00
31	2016-12-18 20:00:00
32	2016-12-19 20:00:00
33	2016-12-20 20:00:00
34	2016-12-22 20:00:00
35	2016-12-25 20:00:00
36	2016-12-28 20:00:00
37	2016-12-30 20:00:00
38	2017-01-02 20:00:00
39	2017-01-04 20:00:00
40	2017-01-13 20:00:00
41	2017-01-16 20:00:00
42	2017-01-18 20:00:00
43	2017-01-22 20:00:00
44	2017-01-23 20:00:00
45	2017-01-28 20:00:00
46	2017-01-29 20:00:00
47	2017-01-30 20:00:00
48	2017-02-02 20:00:00
49	2017-02-03 20:00:00
50	2017-02-04 20:00:00
51	2017-02-05 20:00:00
52	2017-02-06 20:00:00
53	2017-02-10 20:00:00
54	2017-02-13 20:00:00
55	2017-02-15 20:00:00
56	2017-02-17 20:00:00
57	2017-02-18 20:00:00
58	2017-02-20 20:00:00
59	2017-02-22 20:00:00
60	2017-02-24 20:00:00
61	2017-02-26 20:00:00
62	2017-03-02 20:00:00
63	2017-03-03 20:00:00
64	2017-03-04 20:00:00
65	2017-03-07 20:00:00
66	2017-03-08 20:00:00
67	2017-03-11 20:00:00
68	2017-03-12 20:00:00
69	2017-03-13 20:00:00
70	2017-03-19 20:00:00
71	2017-03-24 20:00:00
72	2017-03-25 20:00:00
73	2017-04-02 20:00:00
74	2017-04-09 20:00:00
75	2017-04-16 20:00:00
76	2017-04-25 20:00:00
77	2017-05-09 20:00:00
78	2017-05-12 20:00:00
79	2017-05-24 20:00:00
80	2017-05-25 20:00:00
81	2017-06-13 20:00:00
82	2017-06-24 20:00:00
83	2017-07-24 20:00:00
84	2017-08-25 20:00:00
85	2017-09-17 20:00:00
86	2017-09-25 20:00:00
87	2017-10-13 20:00:00
88	2017-10-21 20:00:00
89	2017-10-24 20:00:00
90	2017-10-25 20:00:00
91	2017-11-04 20:00:00
92	2017-11-06 20:00:00
93	2017-11-11 20:00:00
94	2017-11-13 20:00:00
95	2017-11-19 20:00:00
96	2017-11-23 20:00:00
97	2017-11-25 20:00:00
98	2017-11-29 20:00:00
99	2017-12-01 20:00:00
100	2017-12-02 20:00:00
101	2017-12-04 20:00:00
102	2017-12-08 20:00:00
103	2017-12-15 20:00:00
104	2017-12-20 20:00:00
105	2017-12-25 20:00:00
106	2017-12-27 20:00:00
107	2018-01-04 20:00:00
108	2018-01-09 20:00:00
109	2018-01-18 20:00:00
110	2018-01-27 20:00:00
111	2018-02-05 20:00:00
112	2018-02-12 20:00:00
113	2018-02-21 20:00:00
114	2018-02-25 20:00:00
115	2018-03-01 20:00:00
116	2018-03-03 20:00:00
117	2018-03-04 20:00:00
118	2018-03-09 20:00:00
119	2018-03-15 20:00:00
120	2018-03-20 20:00:00
121	2018-03-25 20:00:00
122	2018-04-01 20:00:00
123	2018-04-06 20:00:00
124	2018-04-10 20:00:00
125	2018-04-17 20:00:00
126	2018-04-25 20:00:00
127	2018-05-03 20:00:00
128	2018-05-13 20:00:00
129	2018-05-24 20:00:00
130	2018-05-29 20:00:00
131	2018-06-01 20:00:00
132	2018-06-23 20:00:00
133	2018-06-26 20:00:00
134	2018-07-17 20:00:00
135	2018-07-25 20:00:00
136	2018-08-10 20:00:00
137	2018-08-25 20:00:00
138	2018-09-25 20:00:00
139	2018-10-05 20:00:00
140	2018-10-06 20:00:00
141	2018-10-08 20:00:00
142	2018-10-12 20:00:00
143	2018-10-15 20:00:00
144	2018-10-21 20:00:00
145	2018-10-23 20:00:00
146	2018-10-25 20:00:00
147	2018-10-29 20:00:00
148	2018-11-08 20:00:00
149	2018-11-17 20:00:00
150	2018-11-21 20:00:00
151	2018-11-25 20:00:00
152	2018-11-30 20:00:00
153	2018-12-06 20:00:00
154	2018-12-14 20:00:00
155	2018-12-19 20:00:00
156	2018-12-25 20:00:00
157	2019-01-03 20:00:00
158	2019-01-13 20:00:00
159	2019-01-19 20:00:00
160	2019-01-24 20:00:00
161	2019-01-25 20:00:00
162	2019-01-31 20:00:00
163	2019-02-01 20:00:00
164	2019-02-06 20:00:00
165	2019-02-10 20:00:00
166	2019-02-14 20:00:00
167	2019-02-15 20:00:00
168	2019-02-17 20:00:00
169	2019-02-18 20:00:00
170	2019-02-20 20:00:00
171	2019-02-24 20:00:00
172	2019-02-25 20:00:00
173	2019-02-27 20:00:00
174	2019-03-04 20:00:00
175	2019-03-05 20:00:00
176	2019-03-08 20:00:00
177	2019-03-16 20:00:00
178	2019-03-17 20:00:00
179	2019-03-18 20:00:00
180	2019-03-19 20:00:00
181	2019-03-20 20:00:00
182	2019-03-22 20:00:00
183	2019-03-25 20:00:00
184	2019-03-27 20:00:00
185	2019-03-30 20:00:00
186	2019-04-03 20:00:00
206	2019-04-04 21:01:41.292
207	2019-04-05 21:01:14.656
208	2019-04-06 21:16:46.046
209	2019-04-07 20:11:24.33
210	2019-04-09 21:44:37.228
211	2019-04-10 21:24:50.453
212	2019-04-11 21:58:06.841
213	2019-04-12 21:07:29.304
214	2019-04-13 21:23:22.11
215	2019-04-15 20:21:32.057
216	2019-04-18 20:33:21.714
217	2019-04-19 21:08:11.515
218	2019-04-21 21:56:32.051
219	2019-04-22 20:31:46.769
220	2019-04-24 20:57:41.728
221	2019-04-26 07:49:07.914
222	2019-04-26 21:45:50.389
223	2019-04-28 20:38:08.791
224	2019-05-02 21:41:05.562
225	2019-05-04 23:25:41.866
226	2019-05-05 20:22:51.065
227	2019-05-06 21:28:42.699
228	2019-05-08 21:14:11.378
229	2019-05-12 19:29:50.743
230	2019-05-13 21:00:56.838
231	2019-05-15 21:32:54.565
232	2019-05-16 21:31:30.699
233	2019-05-19 21:18:37.539
234	2019-05-22 20:33:31.999
235	2019-05-23 21:25:24.182
236	2019-05-24 21:03:47.249
237	2019-05-25 21:27:20.222
238	2019-05-27 21:20:08.019
239	2019-05-29 21:55:10.213
240	2019-06-01 22:01:07.109
241	2019-06-05 21:36:31.216
243	2019-06-09 20:06:17.057065
244	2019-06-11 12:12:16.147612
245	2019-06-14 19:35:07.271234
246	2019-06-16 19:21:26.78733
247	2019-06-19 19:36:10.648472
248	2019-06-20 20:13:01.799891
249	2019-06-21 18:44:56.748117
250	2019-06-22 19:29:52.111825
251	2019-06-24 19:44:50.792076
252	2019-06-25 19:51:07.121091
253	2019-06-28 18:17:02.320732
254	2019-07-01 17:33:58.832088
255	2019-07-04 19:21:53.483798
256	2019-07-05 20:04:05.846919
257	2019-07-06 19:43:48.943018
258	2019-07-07 19:18:11.993542
259	2019-07-14 18:29:25.983576
260	2019-07-16 18:25:14.950234
261	2019-07-22 19:49:28.904635
\.


--
-- Name: opname_id_seq; Type: SEQUENCE SET; Schema: public; Owner: energie-admin
--

SELECT pg_catalog.setval('public.opname_id_seq', 261, true);


--
-- Data for Name: teller; Type: TABLE DATA; Schema: public; Owner: energie-admin
--

COPY public.teller (id, naam, naam_kort, schaal, teken) FROM stdin;
1	Warmte	Warmte	3	1
2	Electriciteit verbruik laag	Verbruik laag	0	1
3	Electriciteit verbruik hoog	Verbruik hoog	0	1
5	Electriciteit teruglevering hoog	Teruglevering h	0	-1
4	Electriciteit teruglevering laag	Teruglevering l	0	-1
\.


--
-- Name: teller_id_seq; Type: SEQUENCE SET; Schema: public; Owner: energie-admin
--

SELECT pg_catalog.setval('public.teller_id_seq', 6, false);


--
-- Data for Name: tellerstand; Type: TABLE DATA; Schema: public; Owner: energie-admin
--

COPY public.tellerstand (id, teller_id, stand, opname_id) FROM stdin;
1	1	1.431	1
2	1	1.614	2
3	1	1.677	3
4	1	1.700	4
5	1	1.759	5
6	1	1.888	6
7	1	3.390	7
8	1	3.845	8
9	1	4.101	9
10	1	4.668	10
11	1	4.863	11
12	1	5.035	12
13	1	5.103	13
14	1	5.346	14
15	1	5.720	15
16	1	6.242	16
17	1	7.170	17
18	1	7.445	18
19	1	8.304	19
20	1	9.115	20
21	1	9.445	21
22	1	9.802	22
23	1	10.599	23
24	1	11.202	24
25	1	11.695	25
26	1	12.190	26
27	1	12.432	27
28	1	13.152	28
29	1	13.769	29
30	1	14.166	30
31	1	14.521	31
32	1	14.664	32
33	1	14.875	33
34	1	15.166	34
35	1	15.615	35
36	1	16.086	36
37	1	16.483	37
38	1	17.171	38
39	1	17.567	39
40	1	19.278	40
41	1	19.868	41
42	1	20.337	42
43	1	21.061	43
44	1	21.463	44
45	1	22.655	45
46	1	22.828	46
47	1	23.011	47
48	1	23.497	48
49	1	23.722	49
50	1	23.889	50
51	1	23.973	51
52	1	24.114	52
53	1	25.315	53
54	1	25.814	54
55	1	26.012	55
56	1	26.337	56
57	1	26.507	57
58	1	26.826	58
59	1	26.939	59
60	1	27.151	60
61	1	27.461	61
62	1	28.082	62
63	1	28.249	63
64	1	28.336	64
65	1	28.647	65
66	1	28.817	66
67	1	29.062	67
68	1	29.070	68
69	1	29.116	69
70	1	29.449	70
71	1	29.656	71
72	1	29.663	72
73	1	29.818	73
74	1	30.023	74
75	1	30.272	75
76	1	30.441	76
77	1	30.721	77
78	1	30.788	78
79	1	30.967	79
80	1	30.981	80
81	1	31.225	81
82	1	31.356	82
83	1	31.731	83
84	1	32.171	84
85	1	32.480	85
86	1	32.611	86
87	1	32.948	87
88	1	33.072	88
89	1	33.124	89
90	1	33.147	90
91	1	33.579	91
92	1	33.890	92
93	1	34.579	93
94	1	34.731	94
95	1	35.479	95
96	1	35.959	96
97	1	36.285	97
98	1	36.945	98
99	1	37.535	99
100	1	37.791	100
101	1	38.155	101
102	1	39.070	102
103	1	40.805	103
104	1	41.703	104
105	1	42.308	105
106	1	42.642	106
107	1	44.083	107
108	1	45.060	108
109	1	46.678	109
110	1	48.094	110
111	1	49.760	111
112	1	51.156	112
113	1	52.953	113
114	1	53.700	114
115	1	54.840	115
116	1	55.775	116
117	1	55.866	117
118	1	56.435	118
119	1	57.002	119
120	1	58.183	120
121	1	58.867	121
122	1	59.468	122
123	1	59.871	123
124	1	59.941	124
125	1	60.064	125
126	1	60.197	126
127	1	60.330	127
128	1	60.510	128
129	1	60.651	129
130	1	60.690	130
131	1	60.721	131
132	1	60.995	132
133	1	61.040	133
134	1	61.275	134
135	1	61.365	135
136	1	61.525	136
137	1	61.675	137
138	1	62.051	138
139	1	62.196	139
140	1	62.215	140
141	1	62.236	141
142	1	62.286	142
143	1	62.326	143
144	1	62.413	144
145	1	62.439	145
146	1	62.465	146
147	1	63.000	147
148	1	63.945	148
149	1	64.720	149
150	1	65.715	150
151	1	66.295	151
152	1	67.301	152
153	1	68.017	153
154	1	69.584	154
155	1	70.650	155
156	1	71.351	156
157	1	73.102	157
158	1	75.024	158
159	1	76.400	159
160	1	77.768	160
161	1	78.097	161
162	1	79.498	162
163	1	79.667	163
164	1	80.627	164
165	1	81.157	165
166	1	81.652	166
167	1	81.765	167
168	1	81.980	168
169	1	82.026	169
170	1	82.223	170
171	1	82.544	171
172	1	82.554	172
173	1	82.666	173
174	1	83.116	174
175	1	83.200	175
176	1	83.437	176
177	1	84.700	177
178	1	84.753	178
179	1	84.834	179
180	1	84.941	180
181	1	85.048	181
182	1	85.090	182
183	1	85.257	183
184	1	85.451	184
185	1	85.518	185
186	1	85.721	186
187	2	228.000	1
188	2	281.000	2
189	2	296.000	3
190	2	306.000	4
191	2	319.000	5
192	2	348.000	6
193	2	396.000	7
194	2	416.000	8
195	2	425.000	9
196	2	435.000	10
197	2	438.000	11
198	2	453.000	12
199	2	457.000	13
200	2	460.000	14
201	2	473.000	15
202	2	489.000	16
203	2	496.000	17
204	2	504.000	18
205	2	520.000	19
206	2	541.000	20
207	2	544.000	21
208	2	551.000	22
209	2	574.000	23
210	2	576.000	24
211	2	580.000	25
212	2	604.000	26
213	2	606.000	27
214	2	615.000	28
215	2	640.000	29
216	2	645.000	30
217	2	668.000	31
218	2	668.000	32
219	2	670.000	33
220	2	674.000	34
221	2	697.000	35
222	2	708.000	36
223	2	712.000	37
224	2	735.000	38
225	2	737.000	39
226	2	770.000	40
227	2	792.000	41
228	2	796.000	42
229	2	809.000	43
230	2	820.000	44
231	2	838.000	45
232	2	850.000	46
233	2	854.000	47
234	2	860.000	48
235	2	862.000	49
236	2	868.000	50
237	2	877.000	51
238	2	880.000	52
239	2	887.000	53
240	2	903.000	54
241	2	907.000	55
242	2	910.000	56
243	2	919.000	57
244	2	928.000	58
245	2	930.000	59
246	2	934.000	60
247	2	950.000	61
248	2	957.000	62
249	2	959.000	63
250	2	968.000	64
251	2	983.000	65
252	2	985.000	66
253	2	999.000	67
254	2	1006.000	68
255	2	1009.000	69
256	2	1034.000	70
257	2	1045.000	71
258	2	1050.000	72
259	2	1092.000	73
260	2	1113.000	74
261	2	1144.000	75
262	2	1178.000	76
263	2	1231.000	77
264	2	1236.000	78
265	2	1286.000	79
266	2	1290.000	80
267	2	1365.000	81
268	2	1398.000	82
269	2	1519.000	83
270	2	1630.000	84
271	2	1724.000	85
272	2	1760.000	86
273	2	1822.000	87
274	2	1848.000	88
275	2	1867.000	89
276	2	1868.000	90
277	2	1907.000	91
278	2	1920.000	92
279	2	1938.000	93
280	2	1954.000	94
281	2	1977.000	95
282	2	1988.000	96
283	2	2002.000	97
284	2	2020.000	98
285	2	2025.000	99
286	2	2031.000	100
287	2	2048.000	101
288	2	2057.000	102
289	2	2086.000	103
290	2	2113.000	104
291	2	2146.000	105
292	2	2162.000	106
293	2	2197.000	107
294	2	2227.000	108
295	2	2261.000	109
296	2	2294.000	110
297	2	2340.000	111
298	2	2363.000	112
299	2	2400.000	113
300	2	2420.000	114
301	2	2431.000	115
302	2	2448.000	116
303	2	2458.000	117
304	2	2467.000	118
305	2	2493.000	119
306	2	2517.000	120
307	2	2537.000	121
308	2	2557.000	122
309	2	2578.000	123
310	2	2597.000	124
311	2	2622.000	125
312	2	2632.000	126
313	2	2682.000	127
314	2	2724.000	128
315	2	2765.000	129
316	2	2779.000	130
317	2	2786.000	131
318	2	2860.000	132
319	2	2876.000	133
320	2	2948.000	134
321	2	2976.000	135
322	2	3036.000	136
323	2	3086.000	137
324	2	3205.000	138
325	2	3236.000	139
326	2	3241.000	140
327	2	3248.000	141
328	2	3255.000	142
329	2	3268.000	143
330	2	3286.000	144
331	2	3291.000	145
332	2	3294.000	146
333	2	3313.000	147
334	2	3340.000	148
335	2	3367.000	149
336	2	3388.000	150
337	2	3402.000	151
338	2	3423.000	152
339	2	3446.000	153
340	2	3478.000	154
341	2	3500.000	155
342	2	3531.000	156
343	2	3580.000	157
344	2	3628.000	158
345	2	3648.000	159
346	2	3663.000	160
347	2	3667.000	161
348	2	3684.000	162
349	2	3686.000	163
350	2	3704.000	164
351	2	3721.000	165
352	2	3729.000	166
353	2	3730.000	167
354	2	3743.000	168
355	2	3746.000	169
356	2	3749.000	170
357	2	3764.000	171
358	2	3766.000	172
359	2	3769.000	173
360	2	3789.000	174
361	2	3791.000	175
362	2	3796.000	176
363	2	3828.000	177
364	2	3835.000	178
365	2	3837.000	179
366	2	3839.000	180
367	2	3841.000	181
368	2	3848.000	182
369	2	3862.000	183
370	2	3863.000	184
371	2	3872.000	185
372	2	3885.000	186
373	3	268.000	1
374	3	315.000	2
375	3	331.000	3
376	3	335.000	4
377	3	354.000	5
378	3	380.000	6
379	3	436.000	7
380	3	487.000	8
381	3	487.000	9
382	3	507.000	10
383	3	517.000	11
384	3	519.000	12
385	3	521.000	13
386	3	536.000	14
387	3	553.000	15
388	3	558.000	16
389	3	582.000	17
390	3	582.000	18
391	3	594.000	19
392	3	607.000	20
393	3	622.000	21
394	3	635.000	22
395	3	640.000	23
396	3	650.000	24
397	3	662.000	25
398	3	663.000	26
399	3	667.000	27
400	3	696.000	28
401	3	703.000	29
402	3	719.000	30
403	3	719.000	31
404	3	724.000	32
405	3	729.000	33
406	3	739.000	34
407	3	747.000	35
408	3	758.000	36
409	3	774.000	37
410	3	780.000	38
411	3	792.000	39
412	3	835.000	40
413	3	841.000	41
414	3	852.000	42
415	3	868.000	43
416	3	874.000	44
417	3	897.000	45
418	3	897.000	46
419	3	901.000	47
420	3	916.000	48
421	3	922.000	49
422	3	922.000	50
423	3	922.000	51
424	3	926.000	52
425	3	946.000	53
426	3	950.000	54
427	3	956.000	55
428	3	967.000	56
429	3	967.000	57
430	3	971.000	58
431	3	980.000	59
432	3	991.000	60
433	3	991.000	61
434	3	1013.000	62
435	3	1020.000	63
436	3	1020.000	64
437	3	1029.000	65
438	3	1034.000	66
439	3	1047.000	67
440	3	1047.000	68
441	3	1051.000	69
442	3	1079.000	70
443	3	1097.000	71
444	3	1097.000	72
445	3	1119.000	73
446	3	1142.000	74
447	3	1163.000	75
448	3	1190.000	76
449	3	1226.000	77
450	3	1247.000	78
451	3	1276.000	79
452	3	1280.000	80
453	3	1332.000	81
454	3	1369.000	82
455	3	1470.000	83
456	3	1590.000	84
457	3	1667.000	85
458	3	1698.000	86
459	3	1761.000	87
460	3	1798.000	88
461	3	1804.000	89
462	3	1813.000	90
463	3	1856.000	91
464	3	1869.000	92
465	3	1892.000	93
466	3	1897.000	94
467	3	1921.000	95
468	3	1943.000	96
469	3	1952.000	97
470	3	1964.000	98
471	3	1982.000	99
472	3	1982.000	100
473	3	1986.000	101
474	3	2015.000	102
475	3	2049.000	103
476	3	2069.000	104
477	3	2082.000	105
478	3	2090.000	106
479	3	2131.000	107
480	3	2151.000	108
481	3	2201.000	109
482	3	2244.000	110
483	3	2285.000	111
484	3	2324.000	112
485	3	2375.000	113
486	3	2392.000	114
487	3	2418.000	115
488	3	2437.000	116
489	3	2437.000	117
490	3	2466.000	118
491	3	2487.000	119
492	3	2506.000	120
493	3	2530.000	121
494	3	2556.000	122
495	3	2582.000	123
496	3	2590.000	124
497	3	2618.000	125
498	3	2669.000	126
499	3	2681.000	127
500	3	2711.000	128
501	3	2750.000	129
502	3	2763.000	130
503	3	2779.000	131
504	3	2856.000	132
505	3	2863.000	133
506	3	2943.000	134
507	3	2979.000	135
508	3	3038.000	136
509	3	3093.000	137
510	3	3189.000	138
511	3	3229.000	139
512	3	3229.000	140
513	3	3232.000	141
514	3	3246.000	142
515	3	3247.000	143
516	3	3262.000	144
517	3	3268.000	145
518	3	3273.000	146
519	3	3282.000	147
520	3	3318.000	148
521	3	3347.000	149
522	3	3359.000	150
523	3	3372.000	151
524	3	3393.000	152
525	3	3411.000	153
526	3	3439.000	154
527	3	3457.000	155
528	3	3477.000	156
529	3	3506.000	157
530	3	3543.000	158
531	3	3568.000	159
532	3	3587.000	160
533	3	3596.000	161
534	3	3615.000	162
535	3	3622.000	163
536	3	3635.000	164
537	3	3642.000	165
538	3	3658.000	166
539	3	3661.000	167
540	3	3662.000	168
541	3	3664.000	169
542	3	3670.000	170
543	3	3680.000	171
544	3	3682.000	172
545	3	3688.000	173
546	3	3706.000	174
547	3	3709.000	175
548	3	3723.000	176
549	3	3745.000	177
550	3	3745.000	178
551	3	3747.000	179
552	3	3752.000	180
553	3	3754.000	181
554	3	3761.000	182
555	3	3763.000	183
556	3	3766.000	184
557	3	3774.000	185
558	3	3780.000	186
559	4	11.000	141
560	4	11.000	142
561	4	22.000	143
562	4	29.000	144
563	4	29.000	145
564	4	29.000	146
565	4	35.000	147
566	4	40.000	148
567	4	42.000	149
568	4	44.000	150
569	4	44.000	151
570	4	44.000	152
571	4	44.000	153
572	4	45.000	154
573	4	45.000	155
574	4	45.000	156
575	4	45.000	157
576	4	45.000	158
577	4	47.000	159
578	4	47.000	160
579	4	47.000	161
580	4	48.000	162
581	4	48.000	163
582	4	48.000	164
583	4	52.000	165
584	4	52.000	166
585	4	52.000	167
586	4	58.000	168
587	4	58.000	169
588	4	58.000	170
589	4	67.000	171
590	4	67.000	172
591	4	67.000	173
592	4	70.000	174
593	4	70.000	175
594	4	70.000	176
595	4	73.000	177
596	4	79.000	178
597	4	79.000	179
598	4	79.000	180
599	4	79.000	181
600	4	79.000	182
601	4	87.000	183
602	4	87.000	184
603	4	95.000	185
604	4	100.000	186
605	5	7.000	141
606	5	30.000	142
607	5	34.000	143
608	5	49.000	144
609	5	53.000	145
610	5	56.000	146
611	5	57.000	147
612	5	75.000	148
613	5	84.000	149
614	5	87.000	150
615	5	88.000	151
616	5	90.000	152
617	5	91.000	153
618	5	93.000	154
619	5	94.000	155
620	5	94.000	156
621	5	96.000	157
622	5	97.000	158
623	5	99.000	159
624	5	101.000	160
625	5	101.000	161
626	5	105.000	162
627	5	105.000	163
628	5	107.000	164
629	5	109.000	165
630	5	117.000	166
631	5	120.000	167
632	5	120.000	168
633	5	125.000	169
634	5	134.000	170
635	5	137.000	171
636	5	143.000	172
637	5	154.000	173
638	5	160.000	174
639	5	164.000	175
640	5	171.000	176
641	5	183.000	177
642	5	183.000	178
643	5	190.000	179
644	5	198.000	180
645	5	201.000	181
646	5	218.000	182
647	5	225.000	183
648	5	237.000	184
649	5	251.000	185
650	5	273.000	186
676	1	85.811	206
677	2	3887.000	206
678	3	3783.000	206
679	4	100.000	206
680	5	277.000	206
681	1	85.838	207
682	2	3889.000	207
683	3	3786.000	207
684	4	100.000	207
685	5	286.000	207
686	1	85.853	208
687	2	3893.000	208
688	5	286.000	208
689	4	107.000	208
690	3	3787.000	208
691	1	85.875	209
692	2	3901.000	209
693	3	3787.000	209
694	4	115.000	209
695	5	286.000	209
696	1	85.903	210
697	2	3906.000	210
698	3	3792.000	210
699	4	115.000	210
700	5	309.000	210
701	1	85.919	211
702	2	3908.000	211
703	3	3793.000	211
704	4	115.000	211
705	5	323.000	211
706	1	85.931	212
707	2	3909.000	212
708	3	3796.000	212
709	4	115.000	212
710	5	335.000	212
711	1	85.947	213
712	2	3911.000	213
713	3	3800.000	213
714	4	115.000	213
715	5	339.000	213
716	1	85.973	214
717	2	3917.000	214
718	3	3800.000	214
719	4	124.000	214
720	5	339.000	214
721	1	86.093	215
722	2	3924.000	215
723	3	3802.000	215
724	4	133.000	215
725	5	353.000	215
726	1	86.140	216
727	2	3930.000	216
728	3	3808.000	216
729	4	133.000	216
730	5	385.000	216
731	1	86.154	217
732	2	3931.000	217
733	3	3809.000	217
734	4	133.000	217
735	5	398.000	217
736	1	86.187	218
737	2	3941.000	218
738	3	3810.000	218
739	4	159.000	218
740	5	398.000	218
741	1	86.202	219
742	2	3946.000	219
743	3	3810.000	219
744	4	171.000	219
745	5	398.000	219
746	1	86.231	220
747	2	3949.000	220
748	3	3813.000	220
749	4	171.000	220
750	5	419.000	220
751	1	86.248	221
752	2	3953.000	221
753	3	3815.000	221
754	4	171.000	221
755	5	428.000	221
756	1	86.261	222
757	2	3953.000	222
758	3	3819.000	222
759	4	171.000	222
760	5	436.000	222
761	1	86.294	223
762	2	3962.000	223
763	3	3819.000	223
764	4	184.000	223
765	5	436.000	223
766	1	86.355	224
767	2	3971.000	224
768	3	3825.000	224
769	4	184.000	224
770	5	470.000	224
771	1	86.391	225
772	2	3977.000	225
773	3	3828.000	225
774	4	195.000	225
775	5	478.000	225
776	1	86.406	226
777	2	3979.000	226
778	3	3828.000	226
779	4	204.000	226
780	5	478.000	226
781	1	86.454	227
782	2	3982.000	227
783	3	3830.000	227
784	4	204.000	227
785	5	488.000	227
786	1	86.616	228
787	2	3985.000	228
788	3	3833.000	228
789	4	204.000	228
790	5	499.000	228
791	1	86.681	229
792	2	3996.000	229
793	3	3838.000	229
794	4	226.000	229
795	5	514.000	229
796	1	86.696	230
797	2	3998.000	230
798	3	3839.000	230
799	4	226.000	230
800	5	531.000	230
801	1	86.719	231
802	2	4002.000	231
803	3	3842.000	231
804	4	226.000	231
805	5	566.000	231
806	1	86.733	232
807	2	4004.000	232
808	3	3845.000	232
809	4	226.000	232
810	5	575.000	232
811	1	86.781	233
812	2	4014.000	233
813	3	3848.000	233
814	4	248.000	233
815	5	579.000	233
816	1	86.821	234
817	2	4020.000	234
818	3	3853.000	234
819	4	248.000	234
820	5	600.000	234
821	1	86.833	235
822	2	4022.000	235
823	3	3856.000	235
824	4	248.000	235
825	5	616.000	235
826	1	86.850	236
827	2	4024.000	236
828	3	3859.000	236
829	4	248.000	236
830	5	631.000	236
831	1	86.863	237
832	2	4028.000	237
833	3	3859.000	237
834	4	258.000	237
835	5	631.000	237
836	1	86.890	238
837	2	4035.000	238
838	3	3860.000	238
839	4	264.000	238
840	5	645.000	238
841	1	86.918	239
842	2	4038.000	239
843	3	3863.000	239
844	4	264.000	239
845	5	669.000	239
846	1	86.959	240
847	2	4050.000	240
848	3	3865.000	240
849	4	283.000	240
850	5	679.000	240
851	1	87.013	241
852	2	4057.000	241
853	3	3870.000	241
854	4	300.000	241
855	5	709.000	241
856	1	87.065	243
857	2	4068.000	243
858	3	3874.000	243
859	4	319.000	243
860	5	734.000	243
861	1	87.085	244
862	2	4074.000	244
863	3	3874.000	244
864	4	331.000	244
865	5	742.000	244
866	1	87.125	245
867	2	4078.000	245
868	3	3880.000	245
869	4	331.000	245
870	5	777.000	245
871	1	87.153	246
872	2	4086.000	246
873	3	3880.000	246
874	4	349.000	246
875	5	777.000	246
876	1	87.193	247
877	2	4092.000	247
878	3	3886.000	247
879	4	349.000	247
880	5	817.000	247
881	1	87.205	248
882	2	4094.000	248
883	3	3887.000	248
884	4	349.000	248
885	5	828.000	248
886	1	87.221	249
887	2	4095.000	249
888	3	3889.000	249
889	4	349.000	249
890	5	842.000	249
891	1	87.233	250
892	2	4095.000	250
893	3	3890.000	250
894	4	367.000	250
895	5	842.000	250
896	1	87.255	251
897	2	4105.000	251
898	3	3891.000	251
899	4	382.000	251
900	5	858.000	251
901	1	87.270	252
902	2	4106.000	252
903	3	3894.000	252
904	4	382.000	252
905	5	871.000	252
906	1	87.307	253
907	2	4112.000	253
908	3	3898.000	253
909	4	382.000	253
910	5	919.000	253
911	1	87.347	254
912	2	4123.000	254
913	3	3899.000	254
914	4	410.000	254
915	5	934.000	254
916	1	87.387	255
917	2	4130.000	255
918	3	3904.000	255
919	4	410.000	255
920	5	977.000	255
921	1	87.398	256
922	2	4131.000	256
923	3	3906.000	256
924	4	410.000	256
925	5	992.000	256
926	1	87.414	257
927	2	4135.000	257
928	3	3907.000	257
929	4	419.000	257
930	5	992.000	257
931	1	87.427	258
932	2	4141.000	258
933	3	3907.000	258
934	4	430.000	258
935	5	992.000	258
936	1	87.508	259
937	2	4158.000	259
938	3	3916.000	259
939	4	443.000	259
940	5	1045.000	259
941	1	87.527	260
942	2	4162.000	260
943	3	3918.000	260
944	4	443.000	260
945	5	1059.000	260
946	1	87.592	261
947	2	4178.000	261
948	3	3925.000	261
949	4	462.000	261
950	5	1109.000	261
\.


--
-- Name: tellerstand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: energie-admin
--

SELECT pg_catalog.setval('public.tellerstand_id_seq', 950, true);


--
-- Name: opname opname_pk; Type: CONSTRAINT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.opname
    ADD CONSTRAINT opname_pk PRIMARY KEY (id);


--
-- Name: teller teller_pk; Type: CONSTRAINT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.teller
    ADD CONSTRAINT teller_pk PRIMARY KEY (id);


--
-- Name: tellerstand tellerstand_pk; Type: CONSTRAINT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.tellerstand
    ADD CONSTRAINT tellerstand_pk PRIMARY KEY (id);


--
-- Name: opname_tijd_uindex; Type: INDEX; Schema: public; Owner: energie-admin
--

CREATE UNIQUE INDEX opname_tijd_uindex ON public.opname USING btree (tijd);


--
-- Name: teller_naam_kort_uindex; Type: INDEX; Schema: public; Owner: energie-admin
--

CREATE UNIQUE INDEX teller_naam_kort_uindex ON public.teller USING btree (naam_kort);


--
-- Name: tellerstand tellerstand_opname_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.tellerstand
    ADD CONSTRAINT tellerstand_opname_id_fk FOREIGN KEY (opname_id) REFERENCES public.opname(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: tellerstand tellerstand_teller_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: energie-admin
--

ALTER TABLE ONLY public.tellerstand
    ADD CONSTRAINT tellerstand_teller_id_fk FOREIGN KEY (teller_id) REFERENCES public.teller(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

