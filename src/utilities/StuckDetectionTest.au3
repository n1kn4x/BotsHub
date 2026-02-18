#CS ===========================================================================
; Author: caustic-kronos (aka Kronos, Night, Svarog)
; Copyright 2025 caustic-kronos
;
; Licensed under the Apache License, Version 2.0 (the 'License');
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
; http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an 'AS IS' BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
#CE ===========================================================================

#include-once
#RequireAdmin
#NoTrayIcon

#include '../../lib/GWA2.au3'
#include '../../lib/GWA2_ID.au3'
#include '../../lib/Utils.au3'

Opt('MustDeclareVars', True)

Global Const $STUCK_DETECTION_TEST_INFORMATIONS = 'Integration test for MoveAggroAndKill stuck detection.'
Global Const $STUCK_DETECTION_TEST_FORWARD_DISTANCE = 500


;~ Move 500 units in front of the player based on current orientation and run MoveAggroAndKill.
Func StuckDetectionTest()
	Local $me = GetMyAgent()
	Local $myX = DllStructGetData($me, 'X')
	Local $myY = DllStructGetData($me, 'Y')
	Local $rotationX = DllStructGetData($me, 'RotationCos')
	Local $rotationY = DllStructGetData($me, 'RotationSin')

	Local $targetX = $myX + ($rotationX * $STUCK_DETECTION_TEST_FORWARD_DISTANCE)
	Local $targetY = $myY + ($rotationY * $STUCK_DETECTION_TEST_FORWARD_DISTANCE)

	Info('Stuck detection integration test: moving from (' & Round($myX, 0) & ', ' & Round($myY, 0) & ') to (' & Round($targetX, 0) & ', ' & Round($targetY, 0) & ') using orientation (' & Round($rotationX, 3) & ', ' & Round($rotationY, 3) & ').')

	If MoveAggroAndKill($targetX, $targetY, 'Stuck detection test (forward 500 units)') == $FAIL Then
		Error('Stuck detection integration test failed while moving forward.')
		Return $FAIL
	EndIf

	Info('Stuck detection integration test succeeded.')
	Return $SUCCESS
EndFunc
