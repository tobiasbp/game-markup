
// Bug: Trigges ogsi attarct mode
wpset 0x600A,1,w,wpdata==0x7,{logerror "<game lives=%X, bonus-life-at=%X>\n", b@6020, (b@6021 * 1000); go}

// Stage begins when when changing to "How high can you get" screen
// Save score to calculate screen score
// #6227 is screen #:  1-girders, 2-pie, 3-elevator, 4-rivets
// To do: Lives left
wpset 0x600A,1,w,wpdata==0xA,{ temp0=(b@60B2*100000)+(b@60B4*10000)+(b@60B3*100); logerror "<stage level=%d, screen=%d, score=%X>\n", b@6229, b@6227, temp0; go}


// Items
// to do: Bonus life awarded, jumped enemy/barrel, check pies
// Bug: Triggers in attract mode attract 
wpset 0x6343,1,w,wpdata==14,{logerror "<item x=%03d, y=%03d>umbrella</item>\n",b@6203,b@6205; go}
wpset 0x6343,1,w,wpdata==0C,{logerror "<item x=%03d, y=%03d>hat</item>\n",b@6203,b@6205; go}
wpset 0x6343,1,w,wpdata==10,{logerror "<item x=%03d, y=%03d>purse</item>\n",b@6203,b@6205; go}
wpset 0x6343,1,w,wpdata==2C,{logerror "<item x=%03d, y=%03d>enemy</item>\n",b@6203,b@6205; go}
wpset 0x6217,1,w,wpdata==1,{logerror "<item x=%03d, y=%03d>hammer</item>\n",b@6203,b@6205; go}
//#6290 = counts down how many rivets are left from 8.  Only count if x pos > 0
wpset 0x6290,1,w,b@6203>0,{logerror "<item x=%03d, y=%03d>rivet</item>\n",b@6203,b@6205; go}

//#6340 - usually 0, changes when mario picks up bonus item. jumps over item turns to 1 quickly, then 2 until bonus disappears

wpset 0x6343,1,w,1,{ printf "Jump: %X", wpdata; go}

// Jumpman dies and during game
wpset 0x6200,1,w,wpdata==0 && b@600A==0xC,{logerror "<score>%X</score>\n<cleared bonus=%X, x=%03d, y=%03d>no</cleared>\n</stage>\n",(b@60B2*100000)+(b@60B4*10000)+(b@60B3*100)-temp0,(b@638C*100),b@6203,b@6205; go}


// Stage cleared
// Bugs: Score sometimes hex? decimal not working?
wpset 0x6388,1,w,wpdata==5,{logerror "<score>%X</score>\n<cleared bonus=%X, x=%03d, y=%03d>yes</cleared>\n</stage>\n",(b@60B2*100000)+(b@60B4*10000)+(b@60B3*100)+(b@638C*100)-temp0,(b@638C*100),b@6203,b@6205; go}

// Game over
wpset 0x600A,1,w,wpdata==0x10,{logerror "<score>%X</score>\n</game>\n", (b@60B2*100000)+(b@60B4*10000)+(b@60B3*100); go}

