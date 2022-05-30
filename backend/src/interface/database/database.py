from sqlalchemy import create_engine, inspect
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine('sqlite:///./despensa.db', connect_args={"check_same_thread": False})
inspector = inspect(engine)

#for table_name in inspector.get_table_names():
#   print(table_name)
#   for column in inspector.get_columns(table_name):
#       print("Column: %s" % column['name'])
#   print()

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()