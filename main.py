import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = {'Steps':[1, 2, 3, 4, 5, 6, 7], 'Seconds':[0.068, 0.203, 0.364,  0.891, 8.125, 55.611, 601.007] }
df = pd.DataFrame(data)

sns.lineplot(x = "Steps", y = "Seconds", data=data).set(title='Execution time by number of steps (Dagmar)')
plt.show()