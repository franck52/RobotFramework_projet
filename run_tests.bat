@echo off
echo Installation des dépendances...
pip install -r requirements.txt

echo.
echo Lancement des tests...
robot -d results tests\test_session_utilisateur.robot

echo.
echo Terminé. Les résultats sont dans le dossier "results".
pause
