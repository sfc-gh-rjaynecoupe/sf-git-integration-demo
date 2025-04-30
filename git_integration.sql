-- Use role that has permissions to create API Integration
USE ROLE ACCOUNTADMIN;

-- Craete and use the warehouse that your session
CREATE OR REPLACE WAREHOUSE GIT_DEMOS_S WAREHOUSE_SIZE = SMALL;
USE WAREHOUSE GIT_DEMOS_S;

-- Database to hold all the objects
CREATE OR REPLACE DATABASE GIT_REPOS;
-- Use the created database
USE DATABASE GIT_REPOS;

-- Create schema to hold all github repositories
CREATE OR REPLACE SCHEMA GITHUB;
USE SCHEMA GITHUB;

CREATE OR REPLACE API INTEGRATION  "sfc-gh-rjaynecoupe_git"
    API_PROVIDER = git_https_api
    -- allowed orgs and repositories
    API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-rjaynecoupe')
    ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY git_integration_demo
    API_INTEGRATION = "sfc-gh-rjaynecoupe_git"
    ORIGIN = 'https://github.com/sfc-gh-rjaynecoupe/sf-git-integration-demo.git';

-- Refresh repoistory
ALTER GIT REPOSITORY git_integration_demo FETCH;

-- List branches or tags or commit hash
LIST @git_integration_demo/branches/main;

-- Run the sql `demo.sql` from main branch root
EXECUTE IMMEDIATE FROM @git_integration_demo/branches/main/demo.sql;


-- Run the sql `cleaup.sql` from main branch root to clean demo objects
-- EXECUTE IMMEDIATE FROM @git_integration_demo/branches/main/demo.sql;
