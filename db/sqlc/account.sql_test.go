package db

import (
	"context"
	"database/sql"
	"github.com/stretchr/testify/require"
	"github.com/zishiguo/simplebank/util"
	"testing"
)

func createRandomAccount(t *testing.T) Account {
	ctx := context.Background()
	user := createRandomUser(t)
	arg := CreateAccountParams{
		Owner:    user.Username,
		Balance:  util.RandomMoney(),
		Currency: util.RandomCurrency(),
	}
	result, err := testQueries.CreateAccount(ctx, arg)
	require.NoError(t, err)
	id, err := result.LastInsertId()
	require.NoError(t, err)
	require.NotZero(t, id)

	account, err := testQueries.GetAccount(ctx, id)
	require.NoError(t, err)
	require.NotEmpty(t, account)
	require.Equal(t, arg.Owner, account.Owner)
	require.Equal(t, arg.Balance, account.Balance)
	require.Equal(t, arg.Currency, account.Currency)

	return account
}

func TestQueries_CreateAccount(t *testing.T) {
	createRandomAccount(t)
}

func TestQueries_GetAccount(t *testing.T) {
	account := createRandomAccount(t)
	require.NotEmpty(t, account)
}

func TestQueries_UpdateAccount(t *testing.T) {
	account := createRandomAccount(t)

	arg := UpdateAccountParams{
		Balance: util.RandomMoney(),
		ID:      account.ID,
	}

	err := testQueries.UpdateAccount(context.Background(), arg)
	require.NoError(t, err)
}

func TestQueries_DeleteAccount(t *testing.T) {
	ctx := context.Background()
	account := createRandomAccount(t)

	err := testQueries.DeleteAccount(ctx, account.ID)
	require.NoError(t, err)

	account2, err := testQueries.GetAccount(ctx, account.ID)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, account2)
}

func TestQueries_ListAccounts(t *testing.T) {
	var lastAccount Account
	for i := 0; i < 10; i++ {
		lastAccount = createRandomAccount(t)
	}

	arg := ListAccountsParams{
		Owner:  lastAccount.Owner,
		Offset: 0,
		Limit:  5,
	}

	accounts, err := testQueries.ListAccounts(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, accounts)

	for _, account := range accounts {
		require.NotEmpty(t, account)
		require.Equal(t, lastAccount.Owner, account.Owner)
	}
}
