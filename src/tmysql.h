#ifndef TMYSQL4_TMYSQL
#define TMYSQL4_TMYSQL

#include "database.h"
#include <set>

class tmysql {
public:
	static bool		inShutdown;

	static int		iDatabaseMTID;
	static int		iStatementMTID;

	static int		lua_Create(lua_State* state);
	static int		lua_Connect(lua_State* state);
	static int		lua_GetTable(lua_State* state);

	static void		RegisterDatabase(Database* mysqldb) { m_databases.insert(mysqldb); }
	static void		DeregisterDatabase(Database* mysqldb) { m_databases.erase(mysqldb); }

	static std::set<Database*>	m_databases;

private:
	static Database* createDatabase(lua_State* state);
};

#endif