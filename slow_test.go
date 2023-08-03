package test

import (
	"math/rand"
	"testing"
)

func TestAlwaysPasses(t *testing.T) {

}

func TestPassesRarely(t *testing.T) {
	if rand.Intn(10) < 8 {
		t.Fail()
	}
}
